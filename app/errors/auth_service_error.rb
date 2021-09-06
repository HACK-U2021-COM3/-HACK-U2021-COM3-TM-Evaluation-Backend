class AuthServiceError < ValidatorError
  def initialize(msg="authentication service error")
    super
  end

end