class PastPlansReqParams < RequestDto
  attr_accessor :title, :sum_time, :details, :user_id
  validates :title, :sum_time, :details, presence: true
  validate :detail_contents_validation

  # rubocop:disable all
  def initialize(params={})
    @title = params[:title]
    @sum_time = params[:sum_time]
    @details = params[:details]

    #validateして異常があった場合
    raise PastPlansValidatorError.new("initialize error") unless valid?
  end
  # rubocop:enable all

  def detail_contents_validation
    detail_contents = @details
    detail_contents.each do |detail_content|
      if detail_content[:stay_time].blank? || detail_content[:order_number].blank? ||
        detail_content[:place_location][:lat].blank? || detail_content[:place_location][:lng].blank?
        errors.add(:details, "details contents are empty!")
      end
    end
    puts errors.full_messages
  end

end
  

  