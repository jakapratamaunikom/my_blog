FactoryGirl.define do
  factory :comment do
    name "MyString"
    email { "#{name}@example.com".downcase }
    content "Это круто!"
    
    after(:build) do |comment|
      comment.article ||= Article.first
      comment.article ||= FactoryGirl.create(:article)
    end
  end

end
