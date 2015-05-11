FactoryGirl.define do
  factory :comment do
    name "MyString"
    email { "#{name}@example.com".downcase }
    content "Это круто!"
    
  end

end
