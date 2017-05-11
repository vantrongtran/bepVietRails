class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.integer :target_id, null:false
      # t.references :category, null:false
      t.string :title, null: false
      t.text :content, null: false
      t.string :type
      t.timestamps
    end
  end
end
