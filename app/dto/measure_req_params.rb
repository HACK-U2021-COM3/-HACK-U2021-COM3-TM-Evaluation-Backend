class MeasureReqParams < RequestDto
  attr_accessor :from, :to, :waypoints
  validates :from, :to, :waypoints, presence: true
  validate  :waypoints_contents_validation
  # rubocop:disable all
  def initialize(params={})
    @from = params[:from]
    @to = params[:to]
    @waypoints = params[:waypoints]

    #validateして異常があった場合
    raise MeasureValidatorError.new("initialize error") unless valid?
  end
  # rubocop:enable all

  def waypoints_contents_validation
    waypoints =  @waypoints
    waypoints.each do |waypoint|
      if waypoint[:point].blank? || waypoint[:order].blank?
        errors.add(:waypoints, "waypoints contents are empty!")
      end
    end
  end

end
