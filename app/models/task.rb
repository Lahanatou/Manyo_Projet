class Task < ApplicationRecord
  validates :title,:content, null:false,presence: true, length: { minimum: 1 }
  scope :orderByCreated_at, -> { order(created_at: :desc) }
  scope :kaminari, -> (kaminari_page){ page(kaminari_page).per(10) }
end
