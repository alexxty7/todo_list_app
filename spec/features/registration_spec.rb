require_relative 'features_helper'

feature 'Registration', js: true do

  feature 'with valid inputs' do
    scenario 'User try to register' do
      sign_up(email: 'test_user@test.com', password: 12345678)

      expect(page).to have_content 'Sign out'
    end
  end

  feature 'with invalid inputs' do
    scenario 'with a too-short password' do
      sign_up(email: 'test_user@test.com', password: 123)

      expect(page).to have_content('Your password is too short.')
    end
  end

end