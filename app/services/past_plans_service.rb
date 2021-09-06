class PastPlansService
  def initialize(req_params)
    @past_plans = {
      user_id: req_params.user_id,
      title: req_params.title,
      sum_time: req_params.sum_time
    }
    @past_plan_details = req_params.details
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
    puts @past_plan_details
    @past_plan_details.each { |insert_past_plan_detail|
      details_dict = {}

      details_dict[:past_plan_id] = past_plan_id

      details_dict[:longitude] = insert_past_plan_detail[:place_location][:lng]
      details_dict[:latitude] = insert_past_plan_detail[:place_location][:lat]
      details_dict[:stay_time] = insert_past_plan_detail[:stay_time]
      details_dict[:order_number] = insert_past_plan_detail[:order_number]

      details_list.append(details_dict)
    }

    puts details_list

    # 予定詳細書き込み
    PastPlanDetail.insert_all!(details_list)
  end
end