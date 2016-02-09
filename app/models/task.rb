class Task < ActiveRecord::Base
  belongs_to :task_list
  has_many :comments
  
  validates :description, presence: true
  validates :task_list, presence: true

  acts_as_list scope: :task_list
end
