require 'rails_helper'

RSpec.describe AuthReqParams, type: :dto do
  describe '#initialize' do
    let(:arp) { AuthReqParams }

    context "正常系の場合" do
      it "newに成功すること" do
        expect(arp.new(token: "test_token")).to be_truthy
      end
    end

    context "異常系の場合" do
      it "エラーを返すこと" do
        expect{arp.new(token: "")}.to raise_error AuthValidatorError
      end
    end
  
  end
end
