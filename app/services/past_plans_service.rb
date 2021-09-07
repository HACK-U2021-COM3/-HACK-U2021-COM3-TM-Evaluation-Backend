class PastPlansService
  def initialize(req_params)
    @req_params = req_params
  end

  # create用set
  def set_for_create
   @past_plans = {
        user_id: @req_params.user_id,
        title: @req_params.title,
        sum_time: @req_params.sum_time
      }
    @past_plan_details = @req_params.details

  end

  # update用set
  def set_for_update
    @past_plans = {
      user_id: @req_params.user_id,
      title: @req_params.title,
      sum_time: @req_params.sum_time
    }

    @past_plan_id = @req_params.plans_id
    @past_plan_details = @req_params.details
  end

  # index用set
  def set_for_index
    @user_id = @req_params.user_id
  end

  # show用set
  def set_for_show
    @user_id = @req_params.user_id
    @past_plan_id = @req_params.plans_id
  end

  # destroy用set
  def set_for_destroy
    @user_id = @req_params.user_id
    @past_plan_id = @req_params.plans_id
  end
  
  def create_past_plan
    begin
      ActiveRecord::Base.transaction do
        # 予定書き込み + result_id取得
        past_plan_id = insert_past_plan
        insert_past_plan_detail(past_plan_id)
      end
    rescue
      raise PastPlansServiceError.new("create_past_plan error")
    end
  end

  def index_past_plans
    past_plans_relation = select_past_plans_by_user_id
    raise PastPlansServiceError.new("index_past_plans error") if past_plans_relation.empty?

    convert_past_plans_to_hash(past_plans_relation)
  end


  def show_past_plan
    fetched_user_id = select_user_id_from_past_plan.attributes["user_id"]
    raise PastPlansServiceError.new("show_past_plan error") unless @user_id == fetched_user_id

    detail_contents_relation = select_past_plan_detail
    raise PastPlansServiceError.new("show_past_plan error") if detail_contents_relation.empty?

    convert_detail_to_hash(detail_contents_relation)
  end


  def insert_past_plan
    PastPlan.create(@past_plans).id
  end

  def insert_past_plan_detail(past_plan_id)
    detail_contents_list = []

    detail_contents = @past_plan_details
    detail_contents.each do |detail_content|
      content_dict = {}

      content_dict[:past_plan_id] = past_plan_id

      content_dict[:longitude] = detail_content[:place_location][:lng]
      content_dict[:latitude] = detail_content[:place_location][:lat]
      content_dict[:stay_time] = detail_content[:stay_time]
      content_dict[:order_number] = detail_content[:order_number]

      detail_contents_list.append(content_dict)
    end
    # 予定詳細書き込み
    PastPlanDetail.insert_all!(detail_contents_list)
  end


  def select_past_plans_by_user_id
    PastPlan.where(user_id: @user_id)
  end

  def convert_past_plans_to_hash(past_plans_relation)
    past_plans_results = []
    past_plans_relation.each do | past_plan_relation |

      #フロントに送るデータ構造の生成
      hash_result = {}
      past_plan_hash = past_plan_relation.attributes

      hash_result[:id] = past_plan_hash["id"]
      hash_result[:title] = past_plan_hash["title"]
      hash_result[:sum_time] = past_plan_hash["sum_time"]
      hash_result[:updated_at] = past_plan_hash["updated_at"]

      past_plans_results.append(hash_result)
    end

    past_plans_results
  end

  def select_user_id_from_past_plan
    PastPlan.find_by(id: @past_plan_id)
  end

  def select_past_plan_detail
    PastPlanDetail.where(past_plan_id: @past_plan_id)
  end

  def convert_detail_to_hash(detail_contents_relation)
    detail_contents_results = []

    detail_contents_relation.each do | content_relation |

      #フロントに送るデータ構造の生成
      hash_result = {}
      content_hash = content_relation.attributes

      location_dict = {}
      location_dict[:lat] = content_hash["latitude"]
      location_dict[:lng] = content_hash["longitude"]

      hash_result[:place_location] = location_dict
      hash_result[:stay_time] = content_hash["stay_time"]
      hash_result[:order_number] = content_hash["order_number"]

      detail_contents_results.append(hash_result)
    end

    detail_contents_results
  end
end