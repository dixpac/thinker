class CreateStories < ActiveRecord::Migration[5.0]
  def change
    create_table :stories do |t|
      t.string :title
      t.string :body
      t.references :user, foreign_key: true
      t.string :picture

      t.timestamps
    end
  end
end
