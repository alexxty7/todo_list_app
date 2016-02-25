require_relative 'features_helper'

feature 'Tasks', js: true do
  given(:user) { create(:user) }

  background do
    sign_in(user)
    list = create(:task_list, user: user)
    task = create(:task, description: "task desc", task_list: list)
  end

  scenario 'User can create tasks' do

    within '.create-task-form' do
      fill_in 'task_title', with: 'New task'
      click_on('Add task')
    end

    expect(page).to have_content('New task')
  end

  scenario 'User can update task title' do

    within '.list-group-item' do
      find('.control-task').trigger(:mouseover)
      all('.edit').first.click
      find('.title').set("new task title\n")
    end
    
    expect(page).to have_content('new task title')
  end

  scenario 'User can delete task' do

    within '.list-group-item' do
      find('.control-task').trigger(:mouseover)
      all('.delete').first.click
    end

    expect(page).to_not have_content('task desc')
  end

  scenario 'User can set deadline' do

    find('.control-task').trigger(:mouseover)
    find('.dropdown-toggle').click
    find('.datetimepicker .switch').click
    find('.datetimepicker .month', text: 'Feb').click
    find('.datetimepicker .day', text: 28).click
    find('.datetimepicker .hour', text: '10:00 PM').click
    find('.datetimepicker .minute', text: '10:20 PM').click

    expect(page).to have_content('Feb 28, 2016 10:20 PM')
  end
end