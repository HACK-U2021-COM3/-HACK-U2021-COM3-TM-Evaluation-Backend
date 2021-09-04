class SearchReqParams < RequestDto
  attr_accessor :query_place
  validates :query_place, presence: true

  def initialize(params = {})
    @query_place = params[:query_place]
    #validateして異常があった場合
    raise SearchValidatorError.new unless valid?
  end


end
  

  