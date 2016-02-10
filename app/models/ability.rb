class Ability
  include CanCan::Ability

  def initialize(user)
   if user
    can :manage, TaskList, user: user
    can :manage, Task, task_list: {user: user}
    can :manage, Comment, task: { task_list: { user: user } }
   end
  end
end
