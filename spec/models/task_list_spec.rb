require 'rails_helper'

RSpec.describe TaskList, type: :model do
  it { should have_many :tasks }
  it { should belong_to :user }

  it { should validate_presence_of :title }
  it { should validate_presence_of :user }
end
