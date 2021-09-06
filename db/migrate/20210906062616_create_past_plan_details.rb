class CreatePastPlanDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :past_plan_details do |t|

      t.references :past_plan, foreign_key: true,  null: false
      t.integer :order_number
      t.float :longitude
      t.float :latitude
      t.integer :stay_time
    end
  end
end
