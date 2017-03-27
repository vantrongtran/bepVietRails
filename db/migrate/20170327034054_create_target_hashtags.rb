class CreateTargetHashtags < ActiveRecord::Migration[5.0]
  def change
    create_table :target_hashtags do |t|
      t.references :hashtag, null: false
      t.integer :target_id, null: false
      t.string :target_type
      t.timestamps
    end
  end
end
