class GoogleInspection < Inspection
  def initialize(token)
    @token = token
    @aud = ENV["AUD_ID"]
  end

  def inspect_token
    validator = GoogleIDToken::Validator.new
    begin
      payload = validator.check(@token, @aud)
    rescue GoogleIDToken::ValidationError
      raise GoogleInspectionError.new
    end

    payload["sub"]

  end

end