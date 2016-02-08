class TaskSerializer < ActiveModel::Serializer
  attributes :id, :description, :completed, :position, :deadline
end
