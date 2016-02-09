class TaskList < ActiveRecord::Base
  has_many :tasks, -> { order(position: :asc) }, dependent: :destroy
  validates :title, presence: true
end
