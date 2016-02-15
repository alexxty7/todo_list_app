class TaskList < ActiveRecord::Base
  has_many :tasks, -> { order(position: :asc) }, dependent: :destroy
  belongs_to :user
  
  validates :title, :user, presence: true
end
