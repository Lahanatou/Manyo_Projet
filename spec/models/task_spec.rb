require 'rails_helper'

RSpec.describe 'Fonction du modèle de tâche', type: :model do
   describe 'Test de validation.' do
    context 'Si le titre de la tâche est vide' do
      it 'La validation échoue.' do
        task = Task.new(title: nil, content: "test")
        expect(task).to be_invalid
        expect(task.errors.full_messages).to eq ["Title doit être rempli(e)", "Title est trop court (au moins un caractère)"]
      end
    end

    context 'Si la description de la tâche est vide.' do
      it 'La validation échoue.' do
        task = Task.new(title: "fin JCI22", content: nil)
        expect(task).to be_invalid
        expect(task.errors.full_messages).to eq ["Content doit être rempli(e)", "Content est trop court (au moins un caractère)"]
      end
    end

    context 'Si le titre et la description de la tâche contiennent des valeurs' do
      it 'Les tâches peuvent être enregistrées.' do
        task = Task.new(title: "fin JCI22", content: "test")
        expect(task).to be_valid
        #expect(task.errors.full_messages).to eq ["Title can't be blank", "Title is too short (minimum is 1 character)"]
      end
    end


    describe 'Search function' do
     context 'Recherche ambiguë du titre dans la méthode scope' do
       it "Les tâches contenant le terme de recherche seront filtrées." do.
         # Check both searched and not searched using the to and not_to matcher
         # Check the number of test data retrieved
       end
     end
     context 'Status search with scope method' do
       it "Les tâches qui correspondent exactement au statut sont réduites." do.
         # Check both searched and not searched using the to and not_to matcher
         # Check the number of test data retrieved
       end
     end
     context 'ambiguous search for title and status search in scope method' do
       it "Les tâches qui contiennent le mot recherché dans le titre et qui correspondent exactement au statut sont réduites." do.
         # Check both searched and not searched using the to and not_to matchers.
         # Check the number of test data retrieved
       end
     end
   end
  end
end
