# TODO: refactor like that, implement search https://www.rubyguides.com/2017/11/prefix-trees-in-ruby/
#
#

module Api
  module Utils
    # tricky to avoid privateness of define_method
    class ApiHelper
      def create_method(name, &block)
        self.class.send(:define_method, name, &block)
      end
    end

    # Main class
    #
    # Creates a Tree which allow to present data like "active record" using OOP, methods
    class ApiFetcher < ApiHelper
      def initialize(hash)
        raise ArgumentError, 'Expected a Hash' unless hash.is_a?(Hash)

        @values = hash

        hash.each do |key, value|
          create_method(key) do
            if value.is_a?(Hash)
              ApiFetcher.new(value)
            else
              value
            end
          end
        end
      end

      # Returns hash or nil if it's not defined.
      #
      # show action for node of tree
      # @return [Hash, nil] the values hash or nil
      def show
        @values || nil
      end
    end
  end
end
