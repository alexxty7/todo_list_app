require_relative 'features_helper'

feature 'Comments', js: true do
  given(:user) { create(:user) }

  background do
    sign_in(user)
    list = create(:task_list, user: user)
    task = create(:task, description: 'task 1', task_list: list)
    comment = create(:comment, task: task)

    click_on 'Comments'
  end

  scenario 'User can create comment' do   
    
    within '.add-comment' do
      fill_in 'note', with: 'new task comment'
      click_button 'Add comment'
    end

    expect(page).to have_content('new task comment')
  end

  scenario 'User can create comment with attachment' do
    
    within '.add-comment' do
      attach_file 'file', "#{Rails.root}/spec/spec_helper.rb"
      fill_in 'note', with: 'new task comment'
      click_button 'Add comment'
    end

    expect(page).to have_content('new task comment')
    expect(page).to have_content('spec_helper.rb')
  end

  scenario 'User can delete comment' do

    within '.comments-list' do
      expect(page).to have_content('MyText')
      find('.delete').click
    end

    expect(page).to_not have_content('MyText')
  end
end