require 'rails_helper'


RSpec.describe 'Fonction du modèle de tâche', type: :model do
  before do
    @user = User.create!(name: 'user1', email: "userexample@gmai.com", password: '123456', admin: false)
  end
   describe 'Test de validation.' do
    context 'Si le titre de la tâche est vide' do
      it 'La validation échoue.' do
        task = Task.new(title: nil, content: "test", deadline: DateTime.now, priority: 'low', status: 'started')
        expect(task).not_to be_valid
      end
    end

    context 'Si la description de la tâche est vide.' do
      it 'La validation échoue.' do
        task = Task.new(title: "fin JCI22", content: nil, deadline: DateTime.now, priority: 'low', status: 'started')
        expect(task).to be_invalid
      end
    end


  context 'Si le titre et la description de la tâche contiennent des valeurs' do
    it 'Les tâches peuvent être enregistrées.' do
      task = Task.new(title: "fin JCI22", content: "test", deadline: DateTime.now, priority: 'low', status: 'started', user_id: @user.id)
      expect(task).to be_valid
    end
  end
end
    describe 'Search function' do
      before do
        @task = Task.create!(title: 'task1',content: 'something', deadline:DateTime.now, priority:"low", status:"started", user_id: @user.id)
        @second_task = Task.create!(title: 'second_task',content: 'something1', deadline:DateTime.now,priority:0,status:1, user_id: @user.id)
        @third_task = Task.create!(title: 'third_task',content: 'something2', deadline:DateTime.now,priority:1,status:2, user_id: @user.id)
      end
     context 'Recherche ambiguë du titre dans la méthode scope' do
       it "Les tâches contenant le terme de recherche seront filtrées." do
         expect(Task.search_sort('task1')).to include(@task)
       end
     end

     context 'Status search with scope method' do
       it "Les tâches qui correspondent exactement au statut sont réduites." do
         expect(Task.status_sort(1)).to include(@second_task)
       end
     end

     context 'ambiguous search for title and status search in scope method' do
       it "Les tâches qui contiennent le mot recherché dans le titre et qui correspondent exactement au statut sont réduites." do
         expect(Task.search_sort('third_task').status_sort(2)).to include(@third_task)
       end
     end
  end
  end
