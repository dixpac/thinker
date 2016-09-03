class ChangeStoryBodyToText < ActiveRecord::Migration[5.0]
  def change
    change_column :stories, :body, :text
  end
end
