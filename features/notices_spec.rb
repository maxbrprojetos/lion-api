require_relative 'acceptance_helper'

feature 'Notices', %q(
  In order to know if there are problems in the system
  As a developer
  I want see notifications
) do

  scenario 'Notices index' do
    visit '/'
    click_on('Sign in with Github')
    page.should have_content('Ok')
  end
end
