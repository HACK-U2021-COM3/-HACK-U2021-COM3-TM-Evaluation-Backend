require 'rails_helper'

RSpec.describe ErrorRespController, type: :controller do
  describe '#handle_status_code' do
  let(:erc) { ErrorRespController }

    context "SearchValidatorErrorであった場合" do
      it "response_bad_requestを呼び出し値を返すこと" do
        wanted = { status: 400, json: { error: 'Bad Request' } }
        expect(erc.handle_status_code(SearchValidatorError.new)).to eq wanted
      end
    end

    context "MeasureValidatorErrorであった場合" do
      it "response_bad_requestを呼び出し値を返すこと" do
        wanted =  { status: 400, json: { error: 'Bad Request' } }
        expect(erc.handle_status_code(MeasureValidatorError.new)).to eq wanted
      end
    end


    context "PastPlansValidatorErrorであった場合" do
      it "response_bad_requestを呼び出し値を返すこと" do
        wanted = { status: 400, json: { error: 'Bad Request' } }
        expect(erc.handle_status_code(PastPlansValidatorError.new)).to eq wanted
      end
    end

    context "PlaceApiErrorであった場合" do
      it "response_internal_server_errorを呼び出し値を返すこと" do
        wanted = { status: 500, json: { error: 'Internal Server Error' } }
        expect(erc.handle_status_code(PlaceApiError.new)).to eq wanted
      end
    end

    context "DirectionApiErrorであった場合" do
      it "response_internal_server_errorを呼び出し値を返すこと" do
        wanted = { status: 500, json: { error: 'Internal Server Error' } }
        expect(erc.handle_status_code(DirectionApiError.new)).to eq wanted
      end
    end

    context "AuthValidatorErrorであった場合" do
      it "response_unauthorizedを呼び出し値を返すこと" do
        wanted = { status: 401, json: { error: 'Unauthorized' } }
        expect(erc.handle_status_code(AuthValidatorError.new)).to eq wanted
      end
    end

    context "AuthServiceErrorであった場合" do
      it "response_unauthorizedを呼び出し値を返すこと" do
        wanted = { status: 401, json: { error: 'Unauthorized' } }
        expect(erc.handle_status_code(AuthServiceError.new)).to eq wanted
      end
      
    end

    context "上記以外であった場合" do
      it "response_not_foundを呼び出し値を返すこと" do
        wanted = { status: 404, json: { error: 'Not Found' } }
        expect(erc.handle_status_code(StandardError.new)).to eq wanted
      end
    end

  end
end
