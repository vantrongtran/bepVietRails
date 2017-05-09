class CreateFoodTargetConditions < ActiveRecord::Migration[5.0]
  def change
    create_table :food_target_conditions do |t|
      t.references :food, foreign_key: true
      t.boolean :is_match,null:false, default: true

      t.timestamps
    end
  end
end
