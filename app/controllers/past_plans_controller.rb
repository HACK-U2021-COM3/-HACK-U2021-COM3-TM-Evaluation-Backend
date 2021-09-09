class PastPlansController < ApplicationController
  before_action :authenticate


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
    req_params = PastPlanIdReqParams.new(user_id: @user_id, plans_id: params[:id].to_i)

    begin
      past_plans_service_obj = PastPlansService.new(req_params)
      past_plans_service_obj.set_for_show
      past_plan_detail_result = past_plans_service_obj.show_past_plan
    rescue => err
      resp_params = ErrorRespController.handle_status_code(err)
      render resp_params
      return
    end

    resp_params = SuccessRespController.handle_status_code(past_plan_detail_result)
    render resp_params
    return
  end


  def update
    begin
      plans_req_params = PastPlansReqParams.new(params)
      id_req_params = PastPlanIdReqParams.new(user_id: @user_id, plans_id: params[:id].to_i)
    rescue => err
      resp_params = ErrorRespController.handle_status_code(err)
      render resp_params
      return
    end

    begin
      past_plans_service_obj = PastPlansService.new({ plans_req_params: plans_req_params, id_req_params: id_req_params })
      past_plans_service_obj.set_for_update
      past_plans_service_obj.update_past_plan_and_detail
    rescue => err
      resp_params = ErrorRespController.handle_status_code(err)
      render resp_params
      return
    end

    resp_params = SuccessRespController.handle_status_code(SuccessRespController::SUCCESS_CODE_NO_CONTENT)
    render resp_params
    return
  end






  def destroy
    req_params = PastPlanIdReqParams.new(user_id: @user_id, plans_id: params[:id].to_i)

    begin
      past_plans_service_obj = PastPlansService.new(req_params)
      past_plans_service_obj.set_for_destroy
      past_plans_service_obj.destroy_past_plan
    rescue => err
      resp_params = ErrorRespController.handle_status_code(err)
      render resp_params
      return
    end

    resp_params = SuccessRespController.handle_status_code(SuccessRespController::SUCCESS_CODE_NO_CONTENT)
    render resp_params
    return
  end
end
