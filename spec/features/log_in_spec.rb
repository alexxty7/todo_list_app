require_relative 'features_helper'

feature 'User sign in', js: true do
  given(:user) { create(:user)}

  scenario 'Registered user try to sign in' do
    sign_in(user)

    expect(page).to have_content 'Sign out'
  end

  scenario 'redirect after login' do
    sign_in(user)
    expect(page).to have_content('Add TODO List')
  end

  scenario 'Non-registered user try to sign in' do
    visit '/#sign_in'
    fill_in 'Email', with: 'wrong@test.com'
    fill_in 'Password', with: '12345678'
    click_on 'Sign in'

    expect(page).to have_content 'Invalid login credentials. Please try again.'
  end

end