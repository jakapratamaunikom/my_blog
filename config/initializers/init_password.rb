if Rails.env.production? 
  ENV["ADMIN_PASSWORD"] = "$2a$10$q2CGpurMxlqqGv3zGjCrq.buJOSWNZ/iSI5rgtrmKACcyR0jBB3VC"
else
  #For test and development is 112233
  ENV["ADMIN_PASSWORD"] = "$2a$10$uyNjmgpUeQ2Dt4cYDrNvDuWOeG5foZ4hqT3fEwhR4ZoAB2nQzYbLi" 
end