FactoryGirl.define do
  factory :work do
    after(:build) do |work|
      en_ac = work.work_contents.build(FactoryGirl.build(:work_content, lang: :en, work: work).attributes)
      en_ac.work = work

      ru_ac = work.work_contents.build(FactoryGirl.build(:work_content, lang: :ru, work: work).attributes)
      ru_ac.work = work
    end
  end

end
