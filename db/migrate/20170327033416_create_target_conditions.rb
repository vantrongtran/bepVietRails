class CreateTargetConditions < ActiveRecord::Migration[5.0]
  def change
    create_table :target_conditions do |t|
      t.integer :target_id, null: false
      t.references :condition_detail, null: false
      t.string :name, null: false
      t.timestamps
    end
  end
end
