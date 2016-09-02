class RemoveUniqIndexOnUsernameFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_index :users, :username
  end
end
