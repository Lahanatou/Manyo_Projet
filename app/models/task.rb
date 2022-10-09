class Task < ApplicationRecord
  validates :title,:content, null:false,presence: true, length: { minimum: 1 }
end
