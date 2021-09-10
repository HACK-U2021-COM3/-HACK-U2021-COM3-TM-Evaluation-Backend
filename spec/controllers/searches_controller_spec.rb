require 'rails_helper'

RSpec.describe SearchesController, type: :controller do
  describe 'GET #search' do
    let(:params) do
      { 
        query_place: "ヤフー 大阪"
      }
    end

    it "動作が正常に動くこと" do
      expect(get :search, params: params).to be_truthy
    end
  
  end
end