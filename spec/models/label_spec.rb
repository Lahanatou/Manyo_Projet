require 'rails_helper'

 RSpec.describe "Fonction du modèle d'étiquetage", type: :model do

   before do
     @user = User.create!(name: 'user1', email: "userexample@gmai.com", password: '123456', admin: false)
   end

   describe 'Test de Validation' do
     context "Si le nom de l'étiquette est une lettre vide" do
       it 'Validation échoue' do
         label = Label.new(name: nil)
         expect(label).not_to be_valid
       end
     end

     context "Si le nom de l'étiquette avait une valeur" do
       it 'Validation réussie' do
         label = Label.new(name: "new label")
         expect(label).to be_valid
       end
     end
   end
 end
