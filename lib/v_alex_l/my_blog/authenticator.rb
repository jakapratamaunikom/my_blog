require 'bcrypt'

class VAlexL::MyBlog::Authenticator
  class BlankPassword < Exception; end

	def initialize(password)
		@password = password
	end

  def allowed_access?
    raise BlankPassword if encrypted_password.blank?
    bcrypt       = ::BCrypt::Password.new(encrypted_password)
    eng_password = ::BCrypt::Engine.hash_secret("#{@password}", bcrypt.salt)
    secure_compare(eng_password, encrypted_password)
  end

  private 
    def encrypted_password
      ENV['ADMIN_PASSWORD'] #from config/initialize/init_password.rb
    end

    def secure_compare(a, b)
      return false if a.blank? || b.blank? || a.bytesize != b.bytesize
      l = a.unpack "C#{a.bytesize}"

      res = 0
      b.each_byte { |byte| res |= byte ^ l.shift }
      res == 0
    end

end
