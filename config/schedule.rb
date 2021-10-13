# frozen_string_literal: true

set :output, 'log/cron.log'

every '0 9 * * *' do
  rake 'load_products'
end
