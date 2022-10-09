require 'rails_helper'

RSpec.describe 'Fonction du modèle de tâche', type: :model do
  describe 'Test de validation.' do
    context 'Si le titre de la tâche est vide' do
      it 'La validation échoue.' do
        task = Task.new(title: nil, content: "test")
        expect(task).to be_invalid
        expect(task.errors.full_messages).to eq ["Title can't be blank", "Title is too short (minimum is 1 character)"]
      end
    end

    context 'Si la description de la tâche est vide.' do
      it 'La validation échoue.' do
        task = Task.new(title: "fin JCI22", content: nil)
        expect(task).to be_invalid
        expect(task.errors.full_messages).to eq ["Content can't be blank", "Content is too short (minimum is 1 character)"]
      end
    end

    context 'Si le titre et la description de la tâche contiennent des valeurs' do
      it 'Les tâches peuvent être enregistrées.' do
        task = Task.new(title: "fin JCI22", content: "test")
        expect(task).to be_valid
        #expect(task.errors.full_messages).to eq ["Title can't be blank", "Title is too short (minimum is 1 character)"]
      end
    end
  end
end
