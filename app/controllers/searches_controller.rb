class SearchesController < ApplicationController
  
  def search

    begin
      search_req_params = SearchReqParams.new(params)
    rescue => err
      resp = ErrorRespController.handle_status_code(err)
      render resp
      return
    end
     
    begin
      got_places = SearchService.new(search_req_params).call_place_api
    rescue => err
      resp = ErrorRespController.handle_status_code(err)
      render resp
      return
    end

    resp =  SuccessRespController.render_success(got_places)
    render resp
    return

  end

end
