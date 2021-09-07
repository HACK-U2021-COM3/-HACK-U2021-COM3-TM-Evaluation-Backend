class PastPlansController < ApplicationController
  before_action :authenticate

  def index
    req_params = PastPlanIdReqParams.new(user_id: @user_id)

    begin
      past_plans_service_obj = PastPlansService.new(req_params)
      past_plans_service_obj.set_for_index
      past_plans_result = past_plans_service_obj.index_past_plans
    rescue => err
      resp_params = ErrorRespController.handle_status_code(err)
      render resp_params
      return
    end

    resp_params = SuccessRespController.handle_status_code(past_plans_result)
    render resp_params
    return
  end

  def show
  end

  def create
    begin
      req_params = PastPlansReqParams.new(params)
    rescue => err
      resp_params = ErrorRespController.handle_status_code(err)
      render resp_params
      return
    end

    begin
      req_params.user_id = @user_id
      past_plans_service_obj = PastPlansService.new(req_params)
      past_plans_service_obj.set_for_create
      past_plans_service_obj.create_past_plan
    rescue => err
      resp_params = ErrorRespController.handle_status_code(err)
      render resp_params
      return
    end

    resp_params = SuccessRespController.handle_status_code(SuccessRespController::SUCCESS_CODE_CREATED)
    render resp_params
    return
  
  end

  def update
  end

  def destroy
  end
end
