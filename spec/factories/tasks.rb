FactoryGirl.define do
  factory :task do
    description "MyString"
    completed false
    position 1
    deadline "2016-02-08 13:42:18"
    task_list nil

    factory :invalid_task do
      description nil
      completed false
      position nil
      deadline nil
      task_list nil
    end
  end
end
