class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token

  def authenticate

    begin
      token = token_and_options(request)&.first
      req_params = AuthReqParams.new({ "token": token })
    rescue => err
      resp_params = ErrorRespController.handle_status_code(err)
      render resp_params
    end

    begin
      user_id = AuthService.new(req_params).operate
    rescue => err
      resp_params = ErrorRespController.handle_status_code(err)
      render resp_params
    end
    @user_id = user_id

  end
end
