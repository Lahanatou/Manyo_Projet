class User < ApplicationRecord
  before_destroy :destroy_action
    before_update :update_action
    validates :name,  presence: true, length: { maximum: 30 }
    validates :email, presence: true,uniqueness: true ,length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
    before_validation { email.downcase! }
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }
    has_many :tasks, dependent: :destroy
    private
    def destroy_action
        if User.where(admin: true).count == 1 && self.admin
        throw(:abort)
        end
    end

    def update_action
        user = User.where(id: self.id).where(admin: true)
        # binding.irb
        if User.where(admin: true).count == 1 && user.present? && self.admin == false
        errors.add(:admin, 'It cannot be removed from. At least one administrator is required')
        throw(:abort)
        end
    end
end
