FactoryGirl.define do
  factory :comment do
    name { generate :random_username }
    email { generate :random_email }
    content { generate :random_content}
    
    after(:build) do |comment|
      comment.article ||= Article.first
      comment.article ||= FactoryGirl.create(:article)
    end
  end

end
