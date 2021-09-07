class PastPlansController < ApplicationController
  before_action :authenticate

  def index
    req_params = PastPlanIdReqParams.new(user_id: @user_id)

    begin
      past_plans_result = PastPlansService.new(req_params).index_past_plans
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
      PastPlansService.new(req_params).create_past_plan
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
