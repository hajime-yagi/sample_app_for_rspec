require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let(:user) { create(:user) }

  describe 'ログイン前' do
    describe 'ユーザー新規登録' do
      context 'フォームの入力値が正常' do
        it 'ユーザーの新規作成が成功する' do
        visit new_user_path
        fill_in 'Email', with: 'a@example.com'
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
        click_button 'SignUp'
        expect(current_path).to eq login_path
        expect(page).to have_content 'User was successfully created.'
      end
    end
      context 'メールアドレスが未入力' do
        it 'ユーザーの新規作成が失敗する' do
       visit new_user_path
       fill_in 'Email', with: ''
       fill_in 'Password', with: 'password'
       fill_in 'Password confirmation', with: 'password'
       click_button 'SignUp'
       expect(page).to have_content '1 error prohibited this user from being saved'
       expect(page).to have_content "Email can't be blank"
       expect(current_path).to eq users_path
        end
      end
      context '登録済のメールアドレスを使用' do
        it 'ユーザーの新規作成が失敗する'  do
        user = create(:user)
        visit new_user_path
        fill_in 'Email', with: user.email
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
        click_button 'SignUp'
        expect(page).to have_content '1 error prohibited this user from being saved'
        expect(page).to have_content 'Email has already been taken'
        expect(current_path).to eq users_path
      end
    end
    describe 'マイページ' do
      context 'ログインしていない状態' do
        it 'マイページへのアクセスが失敗する' do
        visit user_path(user)
        expect(page).to have_content 'Login required'
        expect(current_path).to eq login_path
      end
    end
  end
end
  describe 'ログイン後' do
    before {login_as user}
    describe 'ユーザー編集' do
      context 'フォームの入力値が正常' do
        it 'ユーザーの編集が成功する' do
          visit edit_user_path(user)
          fill_in 'Email', with: 'a@example.com'
          fill_in 'Password', with: 'password'
          fill_in 'Password confirmation', with: 'password'
          click_button 'Update'
          expect(page).to have_content 'User was successfully updated.'
          expect(current_path).to eq user_path(user)
        end
      end
      context 'メールアドレスが未入力' do
        it 'ユーザーの編集が失敗する' do
          visit edit_user_path(user)
          fill_in 'Email', with: ''
          fill_in 'Password', with: 'password'
          fill_in 'Password confirmation', with: 'password'
          click_button 'Update'
          expect(page).to have_content '1 error prohibited this user from being saved'
          expect(page).to have_content "Email can't be blank"
          expect(current_path).to eq user_path(user)
      end
      end
      context '登録済のメールアドレスを使用' do
        it 'ユーザーの編集が失敗する' do
          visit edit_user_path(user)
          another_user = create(:user)
          fill_in 'Email', with: another_user.email
          fill_in 'Password', with: 'password'
          fill_in 'Password confirmation', with: 'password'
          click_button 'Update'
          expect(page).to have_content '1 error prohibited this user from being saved'
          expect(page).to have_content 'Email has already been taken'
          expect(current_path).to eq user_path(user)
        end
      end
      context '他ユーザーの編集ページにアクセス' do
        it '編集ページへのアクセスが失敗する' do
          another_user = create(:user)
          visit edit_user_path(another_user)
          expect(page).to have_content 'Forbidden access.'
          expect(current_path).to eq user_path(user)
      end
    end
  end
    describe 'マイページ' do
      context 'タスクを作成' do
        it '新規作成したタスクが表示される' do
        create(:task, title: 'test', status: 'todo', user: user)
        visit user_path(user)
        expect(page).to have_content 'test'
        expect(page).to have_content 'todo'
        expect(page).to have_link 'Show'
        expect(page).to have_link 'Edit'
        expect(page).to have_link 'Destroy'
      end
    end
  end
 end
end
end