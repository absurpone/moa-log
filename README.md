## usersテーブル

| Column             | Type       | Options                   |
| ------------------ | ---------- | ------------------------- |
| name               | string     | null: false               |
| email              | string     | null: false, unique: true |


### Association
- has_many :posts
- has_many :comments
- has_many :favorites

## postsテーブル

| Column            | Type       | Options                        |
| ----------------- | ---------- | ------------------------------ |
| museum_name       | string     | null: false                    |
| exhibition_title  | string     |                                |
| text              | text       |                                |
| prefecture_id     | integer    | null: false                    |
| impressive_artist | text       |                                |
| impressive_work   | text       |                                |
| rating            | float      | null: false                    |
| user              | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_many :favorites
- has_many :comments

## commentsテーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| text             | text       | null: false                    |
| user             | references | null: false, foreign_key: true |
| item             | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :post

## favoritesテーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| user             | references | null: false, foreign_key: true |
| item             | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :post