class SuccessRespController < ApplicationController

  class << self

    def render_success(resp_params)
      { status: 200, json: { "results": resp_params } }
    end

  end 

end
