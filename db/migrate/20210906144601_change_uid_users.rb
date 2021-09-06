class ChangeUidUsers < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :uid, :string
  end
end
