# frozen_string_literal: true

require './spec/spec_helper'

RSpec.describe Utils::HowSaveChooser do
  describe '#initialize' do
    context 'when choice is provided' do
      it 'sets the choice attribute' do
        chooser = Utils::HowSaveChooser.new(1)
        expect(chooser.choice).to eq(PlacerByFiles)
      end
    end

    context 'when choice is not provided' do
      let(:fake_stdin) { StringIO.new("1\n") }

      before do
        $stdin = fake_stdin
      end

      after do
        $stdin = STDIN
      end

      it 'prompts the user for a choice and sets the choice attribute' do
        allow($stdout).to receive(:puts)
        expect($stdout).to receive(:puts)

        chooser = Utils::HowSaveChooser.new

        expect(chooser.choice).to eq(PlacerByFiles)
      end
    end
  end
end
