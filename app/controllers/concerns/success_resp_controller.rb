class SuccessRespController < ApplicationController

  class << self

    def handle_status_code(success_results)
      { status: 200, json: { "results": success_results } }
    end

  end 

end
