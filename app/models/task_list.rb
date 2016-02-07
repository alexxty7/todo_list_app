class TaskList < ActiveRecord::Base
  validates :title, presence: true
end
