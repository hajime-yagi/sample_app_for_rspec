require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe 'ログイン前' do
    describe 'ユーザー新規登録' do
      context 'フォームの入力値が正常' do
        it 'ユーザーの新規作成が成功する'
        visit _path
        fill_in 'Email', with: 'a@example.com'
        fill_in 'Password', with: 'foobar'
        fill_in 'Password confirmation', with: 'foobar'
        click_button 'SignUp'
        expect(current_path).to eq login_path
        expect(page).to have_content 'User was successfully created.'
      end
      context 'メールアドレスが未入力' do
        it 'ユーザーの新規作成が失敗する'
      end
      context '登録済のメールアドレスを使用' do
        it 'ユーザーの新規作成が失敗する'
      end
    end

    describe 'マイページ' do
      context 'ログインしていない状態' do
        it 'マイページへのアクセスが失敗する'
      end
    end
  end

  describe 'ログイン後' do
    describe 'ユーザー編集' do
      context 'フォームの入力値が正常' do
        it 'ユーザーの編集が成功する'
      end
      context 'メールアドレスが未入力' do
        it 'ユーザーの編集が失敗する'
      end
      context '登録済のメールアドレスを使用' do
        it 'ユーザーの編集が失敗する'
      end
      context '他ユーザーの編集ページにアクセス' do
        it '編集ページへのアクセスが失敗する'
      end
    end

    describe 'マイページ' do
      context 'タスクを作成' do
        it '新規作成したタスクが表示される'
      end
    end
  end
end
