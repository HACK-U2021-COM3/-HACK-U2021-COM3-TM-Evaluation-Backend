class CreatePastPlans < ActiveRecord::Migration[6.1]
  def change
    create_table :past_plans do |t|
      t.references :user, foreign_key: true,  null: false
      t.string :title
      t.integer :sum_time

      t.timestamps
    end
  end
end
