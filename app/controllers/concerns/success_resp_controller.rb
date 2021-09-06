class SuccessRespController < ApplicationController

  SUCCESS_CODE_CREATED = 201
  SUCCESS_CODE_NO_CONTENT = 204

  class << self

    def handle_status_code(success_results)

      case success_results
      when SUCCESS_CODE_CREATED
        response_created
      when SUCCESS_CODE_NO_CONTENT
        response_no_content
      else
        response_ok(success_results)
      end
    end

    ###エラーコードの定義
    # 200 OK
    def response_ok(success_results)
      { status: 200, json: { "results": success_results } }
    end

    # 201 Created
    def response_created
      { status: 201 }
    end

    # 204 No Content
    def response_no_content
      { status: 204 }
    end

  end 

end
