require 'rails_helper'

def visit_with_http_auth(path)
  username = ENV["BASIC_AUTH_USER"]
  password = ENV["BASIC_AUTH_PASSWORD"]
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
  context 'ユーザー登録できない時' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # Basic認証の通過
      visit_with_http_auth root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(find('.menu-content', visible: false).text(:all)).to include '新規登録'
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # 誤った情報でユーザー情報を入力する
      fill_in 'user_name', with: ''
      fill_in 'user_email', with: ''
      fill_in 'user_password', with: ''
      fill_in 'user_password_confirmation', with: ''
      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq('/users')
    end
  end
end
