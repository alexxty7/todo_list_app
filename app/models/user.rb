class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable,
          :omniauthable
  include DeviseTokenAuth::Concerns::User

  has_many :task_lists
end
