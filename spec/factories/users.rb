FactoryBot.define do
  factory :user do
    id { 1 }
   name { 'user' }
   email { 'user@gmail.com' }
   password { '00000000' }
   admin { false }
 end
 factory :admin_user, class: User do
   id { 1 }
   name { 'admin' }
   email { 'admin@gmail.com' }
   password { '99999999' }
   admin { true }

  end
end
