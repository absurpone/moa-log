# アプリ名
MoALog（モアログ）

# 概要
ユーザーが訪れた全国の美術館の情報や写真を手軽に保存・公開でき、  
また他ユーザーの投稿を閲覧して、行きたい美術館が見つけられるアプリケーションです。

# 本番環境
http://18.180.161.218/  
確認用ログイン情報  
email: test@test.com  
password: test55  

# 制作背景
美術館へ行った人の投稿に特化し、手軽に美術館の情報を集められるサービスを目指してこのアプリケーションを作成しました。  
既存のサービスには実際に美術館を訪れた人の投稿にフォーカスしたサービスは無いと感じていたので、  
美術館へ行くのが好きな人、また興味はあるけど行ったことがない人が気軽に見られるものになるよう心がけて制作しました。  

# DEMO
## トップページ（上部）
![topoage](https://user-images.githubusercontent.com/78207434/112251866-5ba28b80-8c9f-11eb-9e97-ea12d4ab3d67.jpg)

## トップページ（下部）
![toppage_bottom](https://user-images.githubusercontent.com/78207434/112260490-58160100-8cad-11eb-9dd8-8b517f8c2514.jpg)

## 新規投稿画面
<img width="937" alt="post_new" src="https://user-images.githubusercontent.com/78207434/112259344-78dd5700-8cab-11eb-8fcc-f0195ef658c7.png">

## 投稿詳細画面
![post_show](https://user-images.githubusercontent.com/78207434/112260171-d3c37e00-8cac-11eb-8141-63879203d380.jpg)



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
