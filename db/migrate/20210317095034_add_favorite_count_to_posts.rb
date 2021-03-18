class AddFavoriteCountToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :favorites_count, :integer
  end
end
