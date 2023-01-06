class Task < ApplicationRecord
  validates :title,:content, null:false,presence: true, length: { minimum: 1 }
  validates :deadline, :priority, :status, null:false,presence: true
  belongs_to :user
  scope :orderByCreated_at, -> { order(created_at: :desc) }
  scope :orderByDeadline,->{order(deadline: :asc) }
  scope :kaminari, -> (kaminari_page){ page(kaminari_page).per(10) }
  enum priority: {low: 0, medium: 1, high: 2 }
  enum status: {pending: 0, started: 1, completed: 2 }
  scope :sort_expired, -> { order(deadline: :asc) }
  scope :sort_priority, -> { order(priority: :desc) }
  scope :ordered, -> { order(created_at: :desc) }
  #scope :status_sort, -> { order(status: :desc) }
  #scope :status_sort, -> (desc){ where(status: status_sort) }
  scope :status_sort, -> (status){ where(status: status) }
  scope :orderByPriority,->{order(priority: :desc) }
  scope :title_sort, -> (search_title){ where(title: search_title) }
  scope :search_sort, -> (search_word){ where('title LIKE ?', "%#{search_word}%") }
end
