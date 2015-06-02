FactoryGirl.define do
  factory :image do
    after(:build) do |image|
      image.work_content ||= FactoryGirl.create(:work_content)

      File.open("#{::Rails.root}/spec/files/img.jpeg") do |f|
        image.file = f
      end
    end
  end

end
