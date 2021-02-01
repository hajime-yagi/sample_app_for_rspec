require 'rails_helper'

RSpec.describe "Tasks", type: :system do
describe 'ログイン前' do 
  describe 'ページ遷移確認' do
    context '新規登録画面にアクセス' do
  it '新規登録ページのアクセスが失敗すること' do
 end
end
   context 'タスク編集ページにアクセス' do
   it '編集ページへのアクセスが失敗すること' do
   end
  end
  context 'タスク詳細ページにアクセス' do
    it '詳細ページへのアクセスに成功すること' do
    end
   end
   context 'タスク一覧ページにアクセス' do
    it '一覧ページへのアクセスに成功すること' do
    end
   end
  end 
end


describe 'ログイン後' do
  
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



    
