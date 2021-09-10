require 'rails_helper'

RSpec.describe SearchReqParams, type: :dto do
  describe '#initialize' do
    let(:srp) { SearchReqParams }

    context "正常系の場合" do
      it "newに成功すること" do
        expect(srp.new(query_place: "ヤフー　大阪")).to be_truthy
      end
    end

    context "異常系の場合" do
      it "エラーを返すこと" do
        expect{srp.new(query_place: "")}.to raise_error SearchValidatorError 
      end
    end
  
  end
end
