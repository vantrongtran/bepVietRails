class CreatePostTips < ActiveRecord::Migration[5.0]
  def change
    create_table :post_tips do |t|

      t.timestamps
    end
  end
end
