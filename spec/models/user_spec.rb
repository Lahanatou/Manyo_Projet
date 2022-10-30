require 'rails_helper'

 RSpec.describe 'User Model Functions', type: :model do
   describe 'Validation testing' do
     context "If the user's name is an empty string" do
       it 'Validation fails' do
         user = User.new(name: '', email: 'first@gmail.com', password_digest: '123456',admin: false)
           user.validate
         expect(user).not_to be_valid
       end
     end
     #
     context "If the user's email address is an empty string" do
       it 'Validation fails' do
         user = User.new(name: 'First', email: '', password_digest: '123456',admin: false)
         user.validate
         expect(user).not_to be_valid
       end
     end

     context "If the user's password is an empty string" do
       it 'Validation fails' do
         user = User.new(name: 'First', email: 'first@gmail.com', password_digest: '123456',admin: false)
          user.validate
         expect(user).not_to be_valid
       end
     end

     context "If the user's email address is already in use" do
       it 'Validation fails' do
         user1 = User.new(name: 'First', email: 'first@gmail.com', password_digest: '123456',admin: false)
         user = User.new(name: 'First', email: 'first@gmail.com', password_digest: '123456',admin: false)
          user.validate
         expect(user).not_to be_valid
       end
     end

     context "If the user's password is less than 6 characters" do
       it 'Validation fails' do
         user = User.new(name: 'First', email: 'first@gmail.com', password_digest: '123456',admin: false)
         user.validate
         expect(user).not_to be_valid
       end
     end

     context "If the user's name has a value, the email address is an unused value, and the password is at least 6 characters long" do
       it 'Validation fails' do
         user = User.new(name: 'user', email: 'user@gmail.com', password_digest: '123456',admin: false)
         user.validate
         expect(user).to be_invalid
       end
     end
   end
 end
