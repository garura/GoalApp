class Goal < ActiveRecord::Base
  validates :name, :user_id, presence: true
  validates :visible, :completed, inclusion: [true, false]

  belongs_to :user
end
