# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:random_username) { Forgery('name').full_name }
  sequence(:random_email) { Forgery('internet').email_address }
  
  sequence(:random_name) { Forgery('name').company_name }
  sequence(:random_title) { Forgery('lorem_ipsum').title  }
  sequence(:random_content) { Forgery('lorem_ipsum').lorem_ipsum_characters  }
  sequence(:random_short_description) { Forgery('lorem_ipsum').lorem_ipsum_characters[0..100] }
end
