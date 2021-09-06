class SearchesController < ApplicationController
  before_action :authenticate
  
  def search

    begin
      req_params = SearchReqParams.new(params)
    rescue => err
      resp_params = ErrorRespController.handle_status_code(err)
      render resp_params
      return
    end
    
    begin
      got_places = SearchService.new(req_params).call_place_api
    rescue => err
      resp_params = ErrorRespController.handle_status_code(err)
      render resp_params
      return
    end

    resp_params =  SuccessRespController.handle_status_code(got_places)
    render resp_params
    return

  end

end
