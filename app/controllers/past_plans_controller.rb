class PastPlansController < ApplicationController
  before_action :authenticate

  def index
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

    SuccessRespController.handle_status_code(SuccessRespController::SUCCESS_CODE_CREATED)
  end

  def update
  end

  def destroy
  end
end
