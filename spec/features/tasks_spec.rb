require_relative 'features_helper'

feature 'Tasks', js: true do
  given(:user) { create(:user) }

  scenario 'User can create tasks' do
    sign_in(user)
    list = create(:task_list, user: user)
  
    within '.create-task-form' do
      fill_in 'task_title', with: 'New task'
      click_on('Add task')
    end

    expect(page).to have_content('New task')
  end

  scenario 'User can update task title' do
    sign_in(user)
    list = create(:task_list, user: user)
    task = create(:task, task_list: list)

    within '.list-group-item' do
      find('.control-task').trigger(:mouseover)
      all('.edit').first.click
      find('.title').set("new task title\n")
    end
    
    expect(page).to have_content('new task title')
  end

  scenario 'User can delete task' do
    sign_in(user)
    list = create(:task_list, user: user)
    task = create(:task, description: "task desc", task_list: list)

    within '.list-group-item' do
      find('.control-task').trigger(:mouseover)
      all('.delete').first.click
    end

    expect(page).to_not have_content('task desc')
  end
end