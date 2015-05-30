FactoryGirl.define do
  factory :work_content do
    title   { generate :random_title }
    content { generate :random_content }
    lang :ru

    after(:build) do |work_content|
      work_content.work ||= FactoryGirl.create(:work)

      File.open("#{::Rails.root}/spec/files/img.jpeg") do |f|
        work_content.image = f
      end

    end
  end

end
