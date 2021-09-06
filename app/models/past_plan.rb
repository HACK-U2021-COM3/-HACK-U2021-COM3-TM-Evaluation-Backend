class PastPlan < ApplicationRecord
  belongs_to :user
  has_many :past_plan_details
end
