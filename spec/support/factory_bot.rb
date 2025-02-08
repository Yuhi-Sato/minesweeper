# frozen_string_literal: true

require 'factory_bot'

Dir.glob(File.expand_path('../../domains/validators/*.rb', __dir__)).sort.each do |file|
  require file
end

Dir.glob(File.expand_path('../../domains/*.rb', __dir__)).sort.each do |file|
  require file
end

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    FactoryBot.find_definitions
  end
end
