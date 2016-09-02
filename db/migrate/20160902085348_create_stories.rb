class CreateStories < ActiveRecord::Migration[5.0]
  def change
    create_table :stories do |t|
      t.string :title, null: false
      t.string :body, null: false
      t.references :user, foreign_key: true, null: false
      t.string :picture

      t.timestamps
    end
  end
end
