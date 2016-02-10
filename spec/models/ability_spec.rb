require 'rails_helper'

RSpec.describe Ability do
  subject(:ability) { Ability.new(user) }

  describe 'for guest' do
    let(:user) { nil }

    it { should_not be_able_to :manage, :all }
  end

  describe 'for authenticated user' do
    let(:user) { create(:user) }
    let(:task_list) { create(:task_list, user: user) }
    let(:task) { create(:task, task_list: task_list) }
    let(:comment) { create(:comment, task: task) }

    it { should be_able_to :create, TaskList }
    it { should be_able_to :destroy, TaskList.new(user: user) }
    it { should be_able_to :update, TaskList.new(user: user) }
    it { should be_able_to :read, TaskList.new(user: user) }

    it { should_not be_able_to :destroy, TaskList.new }
    it { should_not be_able_to :update, TaskList.new }
    it { should_not be_able_to :read, TaskList.new }

    it { should be_able_to :manage, Task.new(task_list: task_list) }
    it { should_not be_able_to :manage, Task.new }

    it { should be_able_to :manage, Comment.new(task: task) }
    it { should_not be_able_to :manage, Comment.new }
  end
end
