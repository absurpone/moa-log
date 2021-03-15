class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string  :museum_name,      null: false
      t.string  :exhibition_title
      t.text    :text
      t.integer :prefecture_id,    null: false
      t.text    :impressive_artist
      t.text    :impressive_work
      t.float   :rating,           null: false
      t.references :user,          foreign_key: true, null: false
      t.timestamps
    end
  end
end
