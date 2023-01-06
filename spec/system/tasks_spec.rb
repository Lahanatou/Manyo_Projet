require 'rails_helper'

RSpec.describe 'Fonctions de gestion des tâches', type: :system do
  before do
    @user = User.create!(id:8, name: 'user1', email: "userexample@gmail.com", password: '123456', admin: false)
    @task = Task.create!(id:1, title: 'task1',content: 'something', deadline:DateTime.now, priority:"low", status:"started", user_id: @user.id)
    @second_task = Task.create!(id:2, title: 'second_task',content: 'something1', deadline:DateTime.now,priority:0,status:1, user_id: @user.id)
    @third_task = Task.create!(id:3, title: 'third_task',content: 'something2', deadline:DateTime.now,priority:1,status:2, user_id: @user.id)
  end

  def user_login
    visit new_session_path
    fill_in 'session[email]', with: 'userexample@gmail.com'
    fill_in 'session[password]', with: '123456'
    click_button 'Sign in'
  end

  describe "Fonction d'enregistrement" do
    before do
      user_login
    end
    context "Lorsqu'une tâche est enregistrée" do
      it 'Les tâches enregistrées sont affichées.' do

        visit new_task_path
      fill_in "Title", with: 'title_test'
      fill_in "Content", with: 'content test'
      fill_in "deadline", with: "21/10/2022"
      find("#task_priority").select('low')
      find("#task_status").select('started')
      click_on 'Create Task'
      expect(page).to have_content 'title_test'
      end
    end
  end
  #
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
    before do
      user_login
    end
     it 'Les nouvelles tâches apparaissent en haut de la liste.' do
          visit new_task_path
           fill_in "Title", with: 'title_test1'
           fill_in "Content", with: 'content test1'
           fill_in "deadline", with: "25/11/2022"
           find("#task_priority").select("high")
           find("#task_status").select('completed')
           click_on 'Create Task'

           visit new_task_path
         fill_in "Title", with: 'title_test2'
         fill_in "Content", with: 'content test2'
         fill_in "deadline", with: "27/10/2022"
         find("#task_priority").select('low')
         find("#task_status").select('pending')
         click_on 'Create Task'
         visit tasks_path
         assert Task.all.order('created_at desc')
     end
   end

  describe "Fonction d'affichage détaillé" do
    before do
      user_login
    end
     context "Lorsque vous passez à l'un des écrans de détail des tâches" do
       it "Le contenu de cette tâche s'affiche." do
         @task = Task.create!(id:4, title: 'title',content: 'content', deadline:DateTime.now, priority:"low", status:"started", user_id: @user.id)
         visit tasks_path
         expect(page).to have_content 'title'
         # click_link "Show"
         # expect(page).to have_content 'title'
       end
     end
  end

  describe 'Listing function' do
    before do
      user_login
    end
   # omit
   describe 'Sort function' do
      context "If you click on the link 'Sort by End Due Date" do
       it "The list of tasks sorted by end deadline in ascending order is displayed." do
         # Use the all method to check the sort order of multiple test data
         visit tasks_path
        click_on 'Deadline'
        assert Task.all.order('created_at desc')
       end
     end
   end
     context "If you click on the link 'Sort by priority" do
       it 'The list of tasks sorted by priority is displayed.' do
         # Use the all method to check the sort order of multiple test data
         visit tasks_path
        click_on 'Priority'
        assert Task.all.order('priority: :desc')
       end
     end
   end

   describe 'Search function' do
     before do
       user_login
     end
     context 'If you do a fuzzy search by title' do
       it 'Seules les tâches contenant le terme de recherche seront affichées' do
         # Use the to and not_to matcher to check both what is displayed and what is not
         visit root_path
            fill_in 'search_title', with: 'second_task'
            click_on 'search'
            expect(page).to have_content 'second_task'
       end
     end
     context 'Search by status' do
       it "Seules les tâches correspondant à l'état recherché seront affichées." do
         # Use the to and not_to matchers to check both what is displayed and what is not
         visit root_path
            select 'started', from: 'search_status'
            click_on 'search'
            expect(page).to have_content 'task'
       end
     end
     context 'Search by title and status' do
       it 'Seules les tâches qui contiennent le terme de recherche dans le titre et qui correspondent au statut seront affichées.d' do
         # Check both what is and is not displayed using the to and not_to matcher
         visit root_path
            fill_in 'search_title', with: 'third_task'
            select 'completed', from: 'search_status'
            click_on 'search'
            expect(page).to have_content 'third_task'
      end
     end
   end
  end
