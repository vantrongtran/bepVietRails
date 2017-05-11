class CreatePostUserPosts < ActiveRecord::Migration[5.0]
  def change
    create_table :post_user_posts do |t|

      t.timestamps
    end
  end
end
