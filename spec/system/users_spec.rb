require 'rails_helper'

def visit_with_http_auth(path)
  username = '34483'
  password = '1212'
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe "Users", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  context 'ユーザー新規登録できる時' do
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # Basic認証の通過
      visit_with_http_auth root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(find('.menu-content', visible: false).text(:all)).to include '新規登録'
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'user_name', with: @user.name
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      fill_in 'user_password_confirmation', with: @user.password_confirmation
      # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(1)
      # トップページへ遷移したことを確認する
      expect(current_path).to eq(root_path)
      # メニュー内にログアウトボタンが表示されることを確認する
      expect(find('.menu-content', visible: false).text(:all)).to include 'ログアウト'
      # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
      expect(find('.menu-content', visible: false).text(:all)).not_to include '新規登録'
      expect(find('.menu-content', visible: false).text(:all)).not_to include 'ログイン'
    end
  end
end
