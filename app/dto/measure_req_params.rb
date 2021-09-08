class MeasureReqParams < RequestDto
  attr_accessor :from, :to, :waypoints
  validates :from, :to, presence: true
  validate  :from_contents_validation
  validate  :to_contents_validation

  # validate 条件指定　値が有ればバリデーションを
  validates :waypoints, presence: true, if: Proc.new{ |params_| params_.waypoints.present?}
  validate :waypoints_contents_validation, if: Proc.new{ |params_| params_.waypoints.present?}

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
    puts "###################################"
    waypoints = @waypoints
    waypoints.each do |waypoint|
      if waypoint[:point].blank? || waypoint[:point_stay_time].blank? || waypoint[:order].blank?
        errors.add(:waypoints, "waypoints contents are empty!")
      end
    end
  end
end
