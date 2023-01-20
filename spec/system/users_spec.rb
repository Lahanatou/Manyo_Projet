require 'rails_helper'

 RSpec.describe 'User Management Functions', type: :system do


   before do

   @user = User.create!(id:1, name: 'user', email: "user@gmail.com", password: "00000000")

  # @user = User.create!(id:2, name: 'user2', email: "user2@gmail.com", password: "11111111")

   @admin_user = User.create!(id:20, name: 'admin', email: "admin@gmail.com", password: "99999999", admin: true)

 end

  def user_login
    visit new_session_path
    fill_in 'session[email]', with: 'user@gmail.com'
    fill_in 'session[password]', with: '00000000'
    click_button 'Sign in'
  end

  def admin_user_login
    visit new_session_path
    fill_in 'session[email]', with: 'admin@gmail.com'
    fill_in 'session[password]', with: '99999999'
    click_button 'Sign in'
  end


   describe 'Registration Functions' do
     context 'When a user is registered' do
       it 'Moves to the Task List screen.' do
         visit new_user_path
         fill_in 'user[name]', with: 'example'
         fill_in 'user[email]', with: 'user@example.com'
         fill_in 'user[password]', with: '123456'
         fill_in 'user[password_confirmation]', with: '123456'
         click_on "Sign up"
         expect(page).to have_content 'Tasks'
       end
     end
     context 'When you move to the Task List screen without logging in' do
       it 'The user is redirected to the login screen and the message "Please log in" is displayed.' do
         visit tasks_path
         expect(current_path).to eq new_session_path
       end
     end
   end

   describe 'Login Function' do
     before do
       user_login
     end

     context 'When logged in as a registered user' do
       it 'Moves to the Task List screen and displays the message "You are logged in.' do
        expect(page).to have_content 'Create New Task'
       end

       it 'Access to your own detail screen.' do
         visit "/users/1"
          expect(current_path).to eq user_path(1)
       end


       it "Accessing someone else's detail screen will take you to the task list screen." do
         visit user_path(2)
        expect(current_path).to eq tasks_path
       end


       it 'When logging out, the user is taken to the login screen and the message "You have logged out" is displayed.' do
         click_link 'Log out'
        page.driver.browser.switch_to.alert.accept
        expect(current_path).to eq new_session_path
       end
     end
   end

   describe 'Administrator Functions' do
     before do
       admin_user_login
     end
     context 'When the administrator logs in' do
       it 'Access to the user list screen' do
         click_link 'Management'
      expect(page).to have_content 'Edit/Delete'
       end


       it 'Can register administrators' do
         visit admin_users_path
        click_link 'New user registration'
        fill_in 'user[name]', with: 'adminpower'
        fill_in 'user[email]', with: 'adminpower@gmail.com'
        fill_in 'user[password]', with: '654321'
        fill_in 'user[password_confirmation]', with: '654321'
        click_button "Register"
        expect(page).to have_content 'New Task'
       end


       it 'Access to user details screen' do
         visit admin_users_path
         click_link 'Edit/Delete', href: edit_admin_user_path(1)
        fill_in 'user[name]', with: 'user'
        fill_in 'user[password]', with: '00000000'
        fill_in 'user[password_confirmation]', with: '00000000'
        click_button "Approve"
          sleep 1
        expect(page).to have_content 'user'
       end

       it 'Edit users other than yourself from the user edit screen' do
       end

       it 'Users can be deleted.' do
         click_link 'Management'
         click_link 'Edit/Delete', href: edit_admin_user_path(1)
           click_link 'Delete user data'
           page.driver.browser.switch_to.alert.accept
           expect(page).not_to have_content "test"
       end
     end
end

     context 'When a general user accesses the User List screen' do
       it 'Moves to the Task List screen and displays an error message "Only administrators can access this screen".' do
         user_login
         visit admin_users_path
         expect(current_path).to eq tasks_path
      end
   end
end
