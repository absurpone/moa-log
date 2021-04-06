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
  context 'ツイート投稿ができるとき'do
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
      # 送信するとPosrモデルのカウントが1上がることを確認する
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
  context 'ツイート投稿ができないとき'do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      # 新規投稿ページへのリンクがない
    end
  end
end