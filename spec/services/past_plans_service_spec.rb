require 'rails_helper'

RSpec.describe PastPlansService, type: :service do
  
  describe '#index_past_plans' do
    let(:pps_for_index) { PastPlansService.new(PastPlanIdReqParams.new(user_id: 1)) }

    it "動作が正常に動くこと" do
      #past_planにレコードを一つ追加
      create(:past_plan)
      
      pps_for_index.set_for_index
      
      expect(pps_for_index.index_past_plans).to be_truthy
    end
  
  end

end