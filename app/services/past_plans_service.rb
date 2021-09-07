class PastPlansService
  def initialize(req_params)
    #create
    @past_plans = {
      user_id: req_params.user_id,
      title: req_params.title,
      sum_time: req_params.sum_time
    }
    @past_plan_details = req_params.details

    #index, show, update, destroy  
    @user_id = req_params.user_id, 
    @past_plan_id = req_params.plan_id

  end


  def index_past_plans
    past_plans_relation = select_past_plans_by_user_id
    raise PastPlansServiceError.new("index_past_plans error") if past_plans.empty?

    past_plans_result = convert_past_plans_from_relation_to_hash(past_plans_relation)
    past_plans_result
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



  def insert_past_plan
    past_plan_id = PastPlan.create(@past_plans).id
    past_plan_id
  end

  def insert_past_plan_detail(past_plan_id)
    details_list = []

    @past_plan_details.each do |insert_past_plan_detail|
      details_dict = {}

      details_dict[:past_plan_id] = past_plan_id

      details_dict[:longitude] = insert_past_plan_detail[:place_location][:lng]
      details_dict[:latitude] = insert_past_plan_detail[:place_location][:lat]
      details_dict[:stay_time] = insert_past_plan_detail[:stay_time]
      details_dict[:order_number] = insert_past_plan_detail[:order_number]

      details_list.append(details_dict)
    end

    puts details_list

    # 予定詳細書き込み
    PastPlanDetail.insert_all!(details_list)
  end


  def select_past_plans_by_user_id
    PastPlan.where(user_id: @user_id)
  end

  def convert_past_plans_from_relation_to_hash(past_plans_relation)

    past_plans_results = []
    past_plans_relation.each do |  past_plan_relation |

      #フロントに送るデータ構造の生成
      hash_result = {}
      past_plan_hash = past_plan_relation.attributes
      hash_result[:id] = past_plan_hash[:id]
      hash_result[:title] = past_plan_hash[:title]
      hash_result[:sum_time] = past_plan_hash[:sum_time]
      hash_result[:updated_at] = past_plan_hash[:updated_at]

      past_plans_results.append(hash_result)
    end

    past_plans_result
  end

end