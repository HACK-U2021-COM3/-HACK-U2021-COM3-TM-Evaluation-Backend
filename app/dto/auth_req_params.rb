class AuthReqParams < RequestDto
  attr_accessor :token
  validates :token, presence: true

  # rubocop:disable all
  def initialize(params={})
    @token = params[:token]
    #validateして異常があった場合
    raise AuthValidatorError.new("initialize error") unless valid?
  end
  # rubocop:enable all
end

