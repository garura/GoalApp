class Goal < ActiveRecord::Base
  validates :visible, :completed, :name, :user_id, presence: true
end
