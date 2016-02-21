module AcceptanceHelpers
  def sign_in(user)
    visit '/#sign_in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'
  end

  def sign_up(options)
    visit '/#sign_up'
    fill_in 'Email', with: options[:email]
    fill_in 'Password', with: options[:password]
    fill_in 'Password confirmation', with: options[:password]
    click_on 'Register'
  end
end

