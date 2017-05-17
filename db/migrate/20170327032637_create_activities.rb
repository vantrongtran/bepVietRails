class CreateActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :activities do |t|
      t.references :user, null: false
      t.integer :target_id
      t.string :target_type
      t.string :action_type
      t.timestamps
    end
  end
end
