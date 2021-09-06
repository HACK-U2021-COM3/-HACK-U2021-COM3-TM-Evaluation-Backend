class RemoveTimestampsColumnUsers < ActiveRecord::Migration[6.1]
  def change
    remove_timestamps :users
  end
end
