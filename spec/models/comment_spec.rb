require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should belong_to :task }

  it { should validate_presence_of :body }
  it { should validate_presence_of :task }
end
