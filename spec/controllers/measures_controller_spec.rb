require 'rails_helper'

RSpec.describe MeasuresController, type: :controller do
  describe 'GET #measure' do
    #herokuのlogからテストデータを抽出
    let(:params) do
      {
        "from"=>{"from_name"=>"34.701697,135.4949926", "from_stay_time"=>0}, 
        "to"=>{"to_name"=>"34.7033026,135.5010669", "to_stay_time"=>0}, 
        "waypoints"=>[{"point"=>"日本、〒530-0018 大阪府大阪市北区小松原町１−２０", "point_stay_time"=>0, "order"=>1}]
      } 
    end

    it "動作が正常に動くこと" do
      expect(get :measure, params: params).to be_truthy
    end
  
  end
end

