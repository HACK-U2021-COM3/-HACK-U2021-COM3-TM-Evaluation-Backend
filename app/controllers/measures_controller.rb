class MeasuresController < ApplicationController
  def measure
    begin
      req_params = MeasureReqParams.new(params)
    rescue => err
      resp_params = ErrorRespController.handle_status_code(err)
      render resp_params
      return
    end

    begin
      got_measures = MeasureService.new(req_params).call_direction_api
    rescue => err
      resp_params = ErrorRespController.handle_status_code(err)
      render resp_params
      return
    end

    resp_params = SuccessRespController.handle_status_code(got_measures)
    render resp_params
    return

  end
end