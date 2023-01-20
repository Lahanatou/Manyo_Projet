class Task < ApplicationRecord
  validates :title,:content, null:false,presence: true, length: { minimum: 1 }
  validates :deadline, :priority, :status, null:false,presence: true
   belongs_to :user
   has_many :labelings, dependent: :destroy
   has_many :labels, through: :labelings, source: :label
  scope :orderByCreated_at, -> { order(created_at: :desc) }
  scope :orderByDeadline,->{order(deadline: :asc) }
  scope :kaminari, -> (kaminari_page){ page(kaminari_page).per(10) }
  enum priority: {low: 0, medium: 1, high: 2 }
  enum status: {pending: 0, started: 1, completed: 2 }
  scope :sort_expired, -> { order(deadline: :asc) }
  scope :sort_priority, -> { order(priority: :desc) }
  scope :ordered, -> { order(created_at: :desc) }
  scope :status_sort, -> (status){ where(status: status) }
  scope :orderByPriority,->{order(priority: :desc) }
  scope :title_sort, -> (search_title){ where(title: search_title) }
  scope :search_sort, -> (search_word){ where('title LIKE ?', "%#{search_word}%") }
  scope :current_user_sort,->(current_user_id){where(user_id: current_user_id)}
  scope :label_sort, -> (search_label){
        tasks = Labeling.where(label_id: search_label)
        ids = tasks.map{ |task| task.task_id }
        where(id: ids)
    }
end
