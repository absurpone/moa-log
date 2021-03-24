# アプリ名
MoALog（モアログ）

# 概要
ユーザーが訪れた全国の美術館の情報や写真を手軽に保存・公開でき、
また他ユーザーの投稿を閲覧して、行きたい美術館が見つけられるアプリケーションです。

# 本番環境
http://18.180.161.218/
ログイン情報（確認用）
email: test@test.com
password: test55

# 制作背景
美術館へ行った人の投稿に特化し、手軽に美術館の情報を集められるサービスを目指してこのアプリケーションを作成しました。
既存のサービスには実際に美術館を訪れた人の投稿にフォーカスしたサービスは無いと感じていたので、
美術館へ行くのが好きな人、また興味はあるけど行ったことがない人が気軽に見られるものになるよう心がけて制作しました。

# DEMO

# 工夫したポイント

# 開発環境

# 今後実装したい機能




# DB設計
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