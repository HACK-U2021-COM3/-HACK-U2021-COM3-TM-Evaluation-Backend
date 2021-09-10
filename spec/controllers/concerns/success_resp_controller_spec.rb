require 'rails_helper'

RSpec.describe SuccessRespController, type: :controller do
  describe '#handle_status_code' do
  let(:src) { SuccessRespController }

    context "下記2つ以外(200であった)であった場合" do
      it "response_createdを呼び出し値を返すこと" do
        success_results = "test"
        wanted =  { status: 200, json: { "results": success_results } }
        expect(src.handle_status_code(success_results)).to eq wanted
      end
    end

    context "SUCCESS_CODE_CREATEDであった場合" do
      it "response_createdを呼び出し値を返すこと" do
        wanted = { status: 201 }
        expect(src.handle_status_code(src::SUCCESS_CODE_CREATED)).to eq wanted
      end
    end

    context "SUCCESS_CODE_NO_CONTENTであった場合" do
      it "response_no_contentを呼び出し値を返すこと" do
        wanted = { status: 204 }
        expect(src.handle_status_code(src::SUCCESS_CODE_NO_CONTENT)).to eq wanted
      end
    
    end
  end
end
