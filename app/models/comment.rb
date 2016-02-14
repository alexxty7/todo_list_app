class Comment < ActiveRecord::Base
  belongs_to :task

  mount_uploader :file_attachment, FileAttachmentUploader
  
  validates :body, :task, presence: true
end
