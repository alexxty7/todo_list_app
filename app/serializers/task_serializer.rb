class TaskSerializer < ActiveModel::Serializer
  attributes :id, :description, :completed, :position, :deadline
  has_many :comments
end
