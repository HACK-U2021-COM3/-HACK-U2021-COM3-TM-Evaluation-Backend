class MeasureReqParams < RequestDto
  attr_accessor :from, :to, :waypoints
  validates :from, :to, :waypoints, presence: true
  validate  :from_contents_validation
  validate  :to_contents_validation
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

  def from_contents_validation
    from_contents = @from

    if from_contents[:from_name].blank? || from_contents[:from_stay_time].blank?
      errors.add(:from_contents, "from contents are empty!")
    end
  end

  def to_contents_validation
    to_contents = @to

    if to_contents[:to_name].blank? || to_contents[:to_stay_time].blank?
      errors.add(:to_contents, "to contents are empty!")
    end
  end

  def waypoints_contents_validation
    waypoints =  @waypoints
    waypoints.each do |waypoint|
      if waypoint[:point].blank? || waypoint[:point_stay_time].blank? || waypoint[:order].blank?
        errors.add(:waypoints, "waypoints contents are empty!")
      end
    end
  end

end
