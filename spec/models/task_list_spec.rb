require 'rails_helper'

RSpec.describe TaskList, type: :model do
  it { should validate_presence_of :title }
end
