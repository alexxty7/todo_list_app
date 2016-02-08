require 'rails_helper'

RSpec.describe TaskList, type: :model do
  it { should have_many :tasks}
  it { should validate_presence_of :title }
end
