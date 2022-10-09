require 'rails_helper'

RSpec.describe 'Fonctions de gestion des tâches', type: :system do
  # before do
  #   FactoryBot.create(:task)
  #   FactoryBot.create(:second_task)
  #   #FactoryBot.create(:third_task)
  # end

  describe "Fonction d'enregistrement" do
    context "Lorsqu'une tâche est enregistrée" do
      it 'Les tâches enregistrées sont affichées.' do
        visit new_task_path
      fill_in "Title", with: 'title_test'
      fill_in "Content", with: 'content test'
      click_on 'Create Task'
      expect(page).to have_content 'title_test'
      end
    end
  end

  describe 'Fonction de visualisation de la liste' do
    context "Si la transition se fait vers l'écran de synthèse" do
      it "Une liste des tâches enregistrées s'affiche." do
        #@task = FactoryBot.create(:task)
        visit new_task_path
      fill_in "Title", with: 'title_test'
      fill_in "Content", with: 'content test'
      click_on 'Create Task'
        visit tasks_path
        expect(page).to have_content 'title_test'
      end
    end
  end
  #
  describe "Fonction d'affichage détaillé" do
     context "Lorsque vous passez à l'un des écrans de détail des tâches" do
       it "Le contenu de cette tâche s'affiche." do
         visit new_task_path
       fill_in "Title", with: 'title_test'
       fill_in "Content", with: 'content test'
       click_on 'Create Task'
         visit tasks_path
         expect(page).to have_content 'title_test'
         click_link "Show"
         expect(page).to have_content 'title_test'
       end
     end
  end
end
