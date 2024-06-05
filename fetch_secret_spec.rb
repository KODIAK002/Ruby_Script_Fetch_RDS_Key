# frozen_string_literal: true

require_relative './fetch_secret'
describe FetchSecret do
  before :each do
    allow(Aws::SecretsManager::Client).to receive(:new).with(region: 'us-west-2').and_returns(true)
  end

  describe '#execute' do
    it 'return a string key' do
      fs = FetchSecret.new
      expect(fs.execute).to eq('return rds_key')
    end
  end
end
