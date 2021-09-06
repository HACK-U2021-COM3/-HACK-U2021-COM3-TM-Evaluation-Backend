class PastPlansReqParams < RequestDto
  attr_accessor :title, :sum_time, :details, :user_id
  validates :title, :sum_time, :details, presence: true
  validate :details_contents_validation

  # rubocop:disable all
  def initialize(params={})
    @title = params[:title]
    @sum_time = params[:sum_time]
    @details = params[:details]

    #validateして異常があった場合
    raise PastPlansValidatorError.new("initialize error") unless valid?
  end
  # rubocop:enable all

  def details_contents_validation
    details =  @details
    details.each do |detail|
      if detail[:stay_time].blank? || detail[:order_number].blank? ||
        detail[:place_location][:lat].blank? || detail[:place_location][:lng].blank?
        errors.add(:details, "details contents are empty!")
      end
    end
  end

end
  

  