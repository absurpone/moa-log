class AddLikesCountToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :like_count, :integer
  end
end
