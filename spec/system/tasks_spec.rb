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
    task_list = create_list(:task,3)
    visit tasks_path
    expect(page).to have_content task_list[0].title
    expect(page).to have_content task_list[1].title
    expect(page).to have_content task_list[2].title
    expect(current_path).to eq tasks_path
    end
   end
  end 
end


describe 'ログイン後' do
  let(:user){ create(:user) }
  let(:task){ create(:task) }
  before {login_as user}
  describe 'タスク新規登録' do
    context '入力が正常' do
      it 'タスク新規登録が成功すること' do
        visit new_task_path
        fill_in 'Title', with: 'タイトル'
        fill_in 'Content', with: '内容'
        select 'todo', from: status
        fill_in 'Deadline', with: DateTime.new(2021,2,2,15,52)
        click_button 'Create Task'
        expect(page).to have_content 'Task was successfully created.'
        expect(page).to have_content  'タイトル'
        expect(page).to have_content  '内容'
        expect(page).to have_content  'todo'
        expect(page).to have_content '2021/2/2 15:52'
        expect(current_path).to eq '/tasks/1'
      
      end
    end
    context '登録済みタスクタイトルを入力' do
      it 'タスク登録に失敗すること' do
        create(:task)
        visit new_task_path
        fill_in 'Title',with: task.title
        fill_in 'Content', with: '内容'
        click_button 'Create Task'
        expect(page).to have_content '1 error prohibited this task from being saved:'
        expect(page).to have_content 'Title has already been taken'
        expect(current_path).to eq tasks_path
      end
     end
    end

describe 'タスク編集' do
  let!(:task) { create(:task, user: user)}
  let(:another_task){ create(:task, user: user)}
     context '入力が正常' do
      it 'タスク編集に成功すること' do
        visit edit_task_path(task)
        fill_in 'Title', with: 'タイトル'
        fill_in 'Content', with: '内容'
        click_button 'Update Task'
        expect(page).to have_content 'Task was successfully updated.'
        expect(page).to have_content 'タイトル'
        expect(page).to have_content '内容'
        expect(current_path).to eq task_path(task)
      end
    end
    context 'タイトル未入力' do
      it 'タスク編集に失敗すること' do
        visit edit_task_path(task)
        fill_in 'Title', with: ''
        fill_in 'Content', with: '内容'
        click_button 'Update Task'
        expect(page).to have_content '1 error prohibited this task from being saved:'
        expect(page).to have_content "Title can't be blank"
        expect(current_path).to eq task_path(task)
      end
    end
    context '登録済みタスクタイトルを入力' do
      it 'タスク編集に失敗すること' do
        visit edit_task_path(task)
        fill_in 'Title',with: another_task.title
        fill_in 'Content',with: '内容'
        click_button 'Update Task'
        expect(page).to have_content '1 error prohibited this task from being saved:'
        expect(page).to have_content 'Title has already been taken'
        expect(current_path).to eq task_path(task)
      end
     end
  
describe 'タスク削除' do
    it 'タスク削除に成功すること' do
      visit root_path
      click_link 'Destroy'
      expect(page.accept_confirm).to eq 'Are you sure?'
      expect(page).to have_content 'Task was successfully destroyed.'
      expect(current_path).to eq tasks_path
      expect(page).to_not have_content task.title

    end
   end
  end
end
end

    
