require_relative 'features_helper'

feature 'Todo list', js: true do
  given(:user) { create(:user) }

  background do 
    sign_in(user) 
    create(:task_list, user: user)
  end

  scenario 'User can create todo_list' do

    click_button('Add TODO List')

    within '.modal-content' do
      fill_in 'name', with: 'New todo list'
      click_on('Create')
    end

    expect(page).to have_content('New todo list')
  end

  scenario 'User can update todo_list title' do

    within '.project-heading' do
      find('.control-project').trigger(:mouseover)
      all('.edit').first.click
      find('.title').set("new list title\n")
    end
    
    expect(page).to have_content('new list title')
  end

  scenario 'User can delete todo_list' do

    within '.project-heading' do
      find('.control-project').trigger(:mouseover)
      all('.delete').first.click
    end

    expect(page).to_not have_content('MyString')
  end
end