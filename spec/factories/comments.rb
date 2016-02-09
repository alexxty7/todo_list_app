FactoryGirl.define do
  factory :comment do
    body "MyText"
    file_attachment nil
    task nil

    factory :invalid_comment do
      body nil
      file_attachment nil
      task nil
    end
  end
end
