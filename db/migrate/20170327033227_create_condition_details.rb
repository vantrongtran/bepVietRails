class CreateConditionDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :condition_details do |t|
      t.references :condition, null: false
      t.string :value
      t.boolean :is_match
      t.timestamps
    end
  end
end
