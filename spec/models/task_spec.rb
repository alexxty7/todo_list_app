require 'rails_helper'

RSpec.describe Task, type: :model do
  it { should belong_to :task_list }
  it { should have_many :comments }

  it { should validate_presence_of :description }
  it { should validate_presence_of :task_list }

end
