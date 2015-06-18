ENV["ADMIN_PASSWORD"] = "$2a$10$uyNjmgpUeQ2Dt4cYDrNvDuWOeG5foZ4hqT3fEwhR4ZoAB2nQzYbLi" if Rails.env.test? || Rails.env.development? 
#For test and development is 112233
#For production is stored in profile file.