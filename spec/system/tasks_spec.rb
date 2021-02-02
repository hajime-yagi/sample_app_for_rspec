require 'rails_helper'

RSpec.describe "Tasks", type: :system do
describe 'ログイン前' do 
  let(:user){ create(:user) }
  let(:task){ create(:task) }
  describe 'ページ遷移確認' do
    context '新規登録画面にアクセス' do
  it '新規登録ページのアクセスが失敗すること' do
  visit new_task_path
  expect(page).to have_content 'Login required'
  expect(current_path).to eq login_path
 end
end
   context 'タスク編集ページにアクセス' do
   it '編集ページへのアクセスが失敗すること' do
    visit edit_task_path(task)
    expect(page).to have_content 'Login required'
    expect(current_path).to eq login_path
   end
  end
  context 'タスク詳細ページにアクセス' do
    it '詳細ページへのアクセスに成功すること' do
      visit task_path(task)
      expect(page).to have_content task.title
      expect(current_path).to eq task_path(task)
    end
   end
   context 'タスク一覧ページにアクセス' do
    it '一覧ページへのアクセスに成功すること' do

    end
   end
  end 
end
end

describe 'ログイン後' do
  before { login_as user }
  describe 'タスク新規登録' do
    context '入力が正常' do
      it 'タスク新規登録が成功すること' do
      end
    end
    context '登録済みタスクタイトルを入力' do
      it 'タスク登録に失敗すること' do
      end
     end


describe 'タスク編集' do
     context '入力が正常' do
      it 'タスク編集に成功すること' do
      end
    end
    context 'タイトル未入力' do
      it 'タスク編集に失敗すること' do
      end
    end
    context '登録済みタスクタイトルを入力' do
      it 'タスク編集に失敗すること' do
      end
     end
  
describe 'タスク削除' do
    it 'タスク削除に成功すること' do
    end
   end
  end
end
end


    
