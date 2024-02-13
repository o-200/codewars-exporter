module Utils
  # +Utils::AccessRequester+
  # was created for delegating access logic and creating validations on email and pswd fields
  # TODO: make basic validations on fields
  class AccessRequester
    attr_accessor :email, :password

    def initialize(email: nil, password: nil)
      @email = email || get_email
      @password = password || get_password

      [@email, @password]
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
