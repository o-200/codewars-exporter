module Utils
  module AccessRequester
    attr_accessor :email, :password

    def request_data(email = nil, password = nil)
      get_email if email.nil?
      get_password if password.nil?
    end

    def get_email
      puts 'Enter your email:'
      self.email = gets.chomp
    end

    def get_password
      puts 'Enter your password:'
      self.password = gets.chomp
    end
  end
end
