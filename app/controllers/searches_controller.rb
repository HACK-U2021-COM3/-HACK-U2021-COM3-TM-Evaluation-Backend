class SearchesController < ApplicationController
  
  def search

    begin
      search_req_params = SearchReqParams.new(params)
    rescue => err
      search_resp_params = ErrorRespController.handle_status_code(err)
      render search_resp_params
      return
    end
    
    begin
      got_places = SearchService.new(search_req_params).call_place_api
    rescue => err
      search_resp_params = ErrorRespController.handle_status_code(err)
      render 
      return
    end

    search_resp_params =  SuccessRespController.handle_status_code(got_places)
    render search_resp_params
    return

  end

end
