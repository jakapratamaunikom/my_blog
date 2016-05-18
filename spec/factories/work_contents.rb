FactoryGirl.define do
  factory :work_content do
    title   { generate :random_title }
    content { generate :random_content }
    lang :ru

    after(:build) do |work_content|
      work_content.work ||= FactoryGirl.create(:work)
    end
  end

end
