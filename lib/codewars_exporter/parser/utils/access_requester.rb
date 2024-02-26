# frozen_string_literal: true

module Utils
  # +Utils::AccessRequester+
  # was created for delegating access logic and creating validations on email and pswd fields
  # TODO: make basic validations on fields
  class AccessRequester
    attr_accessor :email, :password

    def initialize(email=nil, password=nil)
      @email = email || set_email
      @password = password || set_password

      # TODO: change that. void context.
      [@email, @password]
    end

    private

    def set_email
      puts 'Enter your email:'
      @email = gets.chomp
    end

    def set_password
      puts 'Enter your password:'
      @password = gets.chomp
    end
  end
end
