require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do
      # SETUP
      before :each do
        @user1 = User.new(first_name: 'Miguel', last_name: 'Cruz', email: 'm@m.m', password:'verysafepwd', password_confirmation:'verysafepwd');
        @user1.save!
      end
      scenario "Correct login for user" do
        # ACT
        visit root_path
        expect(page).to have_content("Login")
        
        page.find('.login-btn').click
        fill_in 'email', with: 'm@m.m'
        fill_in 'password', with: 'verysafepwd'
        click_button('Submit')
        save_screenshot
        expect(page).to_not have_content("Login")
      end
end
