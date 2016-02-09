class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :file_attachment
end
