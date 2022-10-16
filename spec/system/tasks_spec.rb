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
    #  it "Une liste des tâches enregistrées s'affiche." do
      #   #@task = FactoryBot.create(:task)
      #   visit new_task_path
      # fill_in "Title", with: 'title_test'
      # fill_in "Content", with: 'content test'
      # click_on 'Create Task'
      #   visit tasks_path
      #   expect(page).to have_content 'title_test'
      # end
      it "La liste des tâches créées est affichée dans l'ordre décroissant de la date et de l'heure de création." do
        visit tasks_path
        assert Task.all.order('created_at desc')
      end
    end
  end



  context 'Si une nouvelle tâche est créée' do
     it 'Les nouvelles tâches apparaissent en haut de la liste.' do
             visit new_task_path
           fill_in "Title", with: 'title_test1'
           fill_in "Content", with: 'content test1'
           click_on 'Create Task'

           visit new_task_path
         fill_in "Title", with: 'title_test2'
         fill_in "Content", with: 'content test2'
         click_on 'Create Task'
         visit tasks_path
         assert Task.all.order('created_at desc')
     end
   end

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


  describe 'Listing function' do.
   # omit
   describe 'Sort function' do
     context "If you click on the link 'Sort by End Due Date" do
       it "The list of tasks sorted by end deadline in ascending order is displayed." do
         # Use the all method to check the sort order of multiple test data
       end
     end
     context "If you click on the link 'Sort by priority" do
       it 'The list of tasks sorted by priority is displayed.' do
         # Use the all method to check the sort order of multiple test data
       end
     end
   end
   describe 'Listing function' do.
   # omit
   describe 'Sort function' do
     context "If you click on the link 'Sort by End Due Date" do
       it "La liste des tâches triées par échéance en ordre croissant s'affiche.." do
         # Use the all method to check the sort order of multiple test data
       end
     end
     context "If you click on the link 'Sort by priority" do
       it "La liste des tâches triées par priorité s'affiche." do
         # Use the all method to check the sort order of multiple test data
       end
     end
   end
   describe 'Search function' do
     context 'If you do a fuzzy search by title' do
       it 'Seules les tâches contenant le terme de recherche seront affichées' do.
         # Use the to and not_to matcher to check both what is displayed and what is not
       end
     end
     context 'Search by status' do
       it "Seules les tâches correspondant à l'état recherché seront affichées." do.
         # Use the to and not_to matchers to check both what is displayed and what is not
       end
     end
     context 'Search by title and status' do
       it 'Seules les tâches qui contiennent le terme de recherche dans le titre et qui correspondent au statut seront affichées.d' do.
         # Check both what is and is not displayed using the to and not_to matcher
      end
     end
   end
 end
   end
end
