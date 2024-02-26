# frozen_string_literal: true

require './spec/spec_helper'

RSpec.describe Utils::AccessRequester do
  before do
    @email = 'test@example.com'
    @password = 'password'
  end

  context 'with ready data' do
    it 'sets the email and password' do
      requester = Utils::AccessRequester.new(@email, @password)

      expect(requester.email).to eq('test@example.com')
      expect(requester.password).to eq('password')
    end
  end

  context 'without data' do
    it 'without all' do
      allow_any_instance_of(Utils::AccessRequester).to receive(:gets).and_return("test@example.com\n", "password\n")

      requester = Utils::AccessRequester.new

      expect(requester.email).to eq('test@example.com')
      expect(requester.password).to eq('password')
    end

    it 'with email, without password' do
      allow_any_instance_of(Utils::AccessRequester).to receive(:gets).and_return(@password)

      requester = Utils::AccessRequester.new(@email)

      expect(requester.email).to eq('test@example.com')
      expect(requester.password).to eq('password')
    end

    # wtf
    it 'with password, without email' do
      allow_any_instance_of(Utils::AccessRequester).to receive(:gets).and_return(@email)

      requester = Utils::AccessRequester.new(nil, @password)

      expect(requester.email).to eq('test@example.com')
      expect(requester.password).to eq('password')
    end
  end
end
