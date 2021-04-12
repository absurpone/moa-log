require 'rails_helper'

def visit_with_http_auth(path)
  username = ENV["BASIC_AUTH_USER"]
  password = ENV["BASIC_AUTH_PASSWORD"]
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe '投稿機能', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.build(:post)
  end
  context '投稿ができるとき'do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      visit_with_http_auth new_user_session_path
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 新規投稿ページへのリンクがあることを確認する
      expect(find('.menu-content', visible: false).text(:all)).to include '新規投稿'
      # 投稿ページに移動する
      visit new_post_path
      # フォームに情報を入力する
      attach_file('public/images/test_image.png')
      select '愛知県', from: 'post_prefecture_id'
      fill_in 'post_museum_name', with: @post.museum_name
      find('#star').find("img[alt='4']").click
      fill_in 'post_exhibition_title', with: @post.exhibition_title
      fill_in 'post_impressive_artist', with: @post.impressive_artist
      fill_in 'post_impressive_work', with: @post.impressive_work
      fill_in 'post_text', with: @post.text
      # 送信するとPostモデルのカウントが1上がることを確認する
      expect{
      find('input[name="commit"]').click
      }.to change { Post.count }.by(1)
      # トップページに遷移したことを確認する
      expect(current_path).to eq(root_path)
      # トップページには先ほど投稿した内容のツイートが存在することを確認する（画像）
      expect(page).to have_selector "img[src$='test_image.png']"
      # トップページには先ほど投稿した内容のツイートが存在することを確認する（タイトル）
      expect(page).to have_content(@post_museum_name)
    end
  end
  context '投稿ができないとき'do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに移動
      visit_with_http_auth root_path
      # 新規投稿ボタンをクリックする
      find('div[class="new-post-btn"]').click
      # ログイン画面に遷移していることを確認する
      expect(current_path).to eq(new_user_session_path)
    end

    it '投稿時必須の内容が無記入だと投稿できない' do
      # ログインする
      visit_with_http_auth new_user_session_path
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 新規投稿ページへのリンクがあることを確認する
      expect(find('.menu-content', visible: false).text(:all)).to include '新規投稿'
      # 投稿ページに移動する
      visit new_post_path
      # 必須の項目を記入しない
      fill_in 'post_exhibition_title', with: @post.exhibition_title
      fill_in 'post_impressive_artist', with: @post.impressive_artist
      fill_in 'post_impressive_work', with: @post.impressive_work
      fill_in 'post_text', with: @post.text
      # 送信してもPostモデルのカウントが変わらないことを確認する
      expect{
      find('input[name="commit"]').click
      }.to change { Post.count }.by(0)
      # 新規投稿ページにとどまっていることを確認する
      expect(current_path).to eq('/posts')
    end
  end
end

RSpec.describe '投稿編集', type: :system do
  before do
    @post1 = FactoryBot.create(:post)
    @post2 = FactoryBot.create(:post)
  end

  context '投稿編集できるとき' do
    it 'ログインしたユーザーは自分の投稿を編集できる' do
      # 投稿1を投稿したユーザーでログインする
      # ログインする
      visit_with_http_auth new_user_session_path
      fill_in 'user_email', with: @post1.user.email
      fill_in 'user_password', with: @post1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 投稿1 の詳細ページへ遷移する
      visit post_path(@post1.id)
      # 投稿1に「編集」ボタンがあることを確認する
      expect(page).to have_link title: '投稿の編集', href: edit_post_path(@post1)
      # 編集ページへ遷移する
      visit edit_post_path(@post1)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(
        find('#post_museum_name').value
      ).to eq(@post1.museum_name)
      expect(
        find('#post_exhibition_title').value
      ).to eq(@post1.exhibition_title)
      expect(
        find('#post_impressive_artist').value
      ).to eq(@post1.impressive_artist)      
      expect(
        find('#post_text').value
      ).to eq(@post1.text)
      # 投稿内容を編集する
      fill_in 'post_museum_name', with: "編集した+{@post.museum_name}"
      find('#star').find("img[alt='2']").click
      fill_in 'post_exhibition_title', with: "編集した+#{@post1.exhibition_title}"
      fill_in 'post_impressive_artist', with: "編集した+#{@post1.impressive_artist}"
      fill_in 'post_impressive_work', with: "編集した+#{@post1.impressive_work}"
      fill_in 'post_text', with: "編集した+#{@post1.text}"
      # 編集してもTweetモデルのカウントは変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Post.count }.by(0)
      # 投稿詳細画面に遷移する
      expect(current_path).to eq(post_path(@post1.id))
      # トップページには先ほど変更した内容の投稿が存在することを確認する（テキスト）
      expect(page).to have_content("編集した+#{@post1.text}")
    end
  end
end