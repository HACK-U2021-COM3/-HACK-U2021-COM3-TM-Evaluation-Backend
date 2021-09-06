class AuthService
  def initialize(req_params)
    @token = req_params.token
  end

  def operate
    #検証
    inspection = GoogleInspection.new(@token)
    begin
      unique_id = inspect_token(inspection)
    rescue
      raise AuthServiceError.new
    end

    # ユーザーidが既に登録されているかどうか
    u = User.find_by(uid: unique_id)

    # 登録されていた場合は外部キーで紐づけるためにuserテーブルのidを返す, 登録されていない場合は新規挿入してuserテーブルのidを返す
    u.present? ? u.id : User.create(uid: unique_id).id
  end

  def inspect_token(inspection)
    inspection.inspect_token
  end

end