require 'rails_helper'
RSpec.describe 'Fonctions de gestion des étiquettes', type: :system do
  before do
    @user = User.create!(id:14, name: 'user14', email: "userexample14@gmail.com", password: '123456', admin: false)
    @label = Label.new(id:24, name: "new label14", user_id: @user.id)
  end
  def user_login
    visit new_session_path
    fill_in 'session[email]', with: 'userexample14@gmail.com'
    fill_in 'session[password]', with: '123456'
    click_button 'Sign in'
  end
  describe "Fonction d'enregistrement" do
    before do
      user_login
    end
    context "Lorsque les étiquettes sont enregistrées" do
      it 'Les étiquettes enregistrées sont affichées.' do
          visit new_label_path
        fill_in 'New Label Name', with: 'Labelnew'
        click_on 'Save Label'
          visit new_task_path
          expect(page).to have_content 'Labelnew'
      end
    end
  end
  describe "Fonction d'affichage de liste" do
    before do
      user_login
    end
    context "Lors de la transition vers lécran de liste" do
      it "Une liste des étiquettes enregistrées s'affiche." do
        visit new_label_path
      fill_in 'New Label Name', with: 'Labelnew1'
      click_on 'Save Label'
      visit new_label_path
    fill_in 'New Label Name', with: 'Labelnew2'
    click_on 'Save Label'
    visit new_task_path
    sleep 8
    expect(page).to have_content 'Labelnew1'
    #expect(page).to have_content('Labelnew1', 'Labelnew2')
      end
    end
  end
end
