require 'rails_helper'


RSpec.describe 'Fonction du modèle de tâche', type: :model do
   describe 'Test de validation.' do
    context 'Si le titre de la tâche est vide' do
      it 'La validation échoue.' do
        task = Task.new(title: nil, content: "test", deadline: DateTime.now, priority: 'low', status: 'started')
        expect(task).to be_invalid
        expect(task.errors.full_messages).to eq ["Title doit être rempli(e)", "Title est trop court (au moins un caractère)"]
      end
    end
  end
    context 'Si la description de la tâche est vide.' do
      it 'La validation échoue.' do
        task = Task.new(title: "fin JCI22", content: nil, deadline: DateTime.now, priority: 'low', status: 'started')
        expect(task).to be_invalid
        expect(task.errors.full_messages).to eq ["Content doit être rempli(e)", "Content est trop court (au moins un caractère)"]
      end
    end

    context 'Si le titre et la description de la tâche contiennent des valeurs' do
      it 'Les tâches peuvent être enregistrées.' do
        task = Task.new(title: "fin JCI22", content: "test", deadline: DateTime.now, priority: 'low', status: 'started')
        expect(task).to be_valid
      end
    end

    describe 'Search function' do
      before do
        @task = Task.create!(title: 'task1',content: 'something', deadline:DateTime.now, priority:"low", status:"started")
        @second_task = Task.create!(title: 'second_task',content: 'something1', deadline:DateTime.now,priority:0,status:1)
        @third_task = Task.create!(title: 'third_task',content: 'something2', deadline:DateTime.now,priority:1,status:2)
      end
     context 'Recherche ambiguë du titre dans la méthode scope' do
       it "Les tâches contenant le terme de recherche seront filtrées." do
         # Check both searched and not searched using the to and not_to matcher
         # Check the number of test data retrieved
         expect(Task.search_sort('task1')).to include(@task)
       end
     end

     context 'Status search with scope method' do
       it "Les tâches qui correspondent exactement au statut sont réduites." do
         # Check both searched and not searched using the to and not_to matcher
         # Check the number of test data retrieved
         expect(Task.status_sort(1)).to include(@second_task)
       end
     end

     context 'ambiguous search for title and status search in scope method' do
       it "Les tâches qui contiennent le mot recherché dans le titre et qui correspondent exactement au statut sont réduites." do
         # Check both searched and not searched using the to and not_to matchers.
         # Check the number of test data retrieved
         expect(Task.search_sort('third_task').status_sort(2)).to include(@third_task)
       end
     end
  end
  end
