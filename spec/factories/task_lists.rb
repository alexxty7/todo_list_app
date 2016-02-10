FactoryGirl.define do
  factory :task_list do
    title "MyString"
    user nil
    factory :invalid_task_list do
      title nil
    end
  end
end
