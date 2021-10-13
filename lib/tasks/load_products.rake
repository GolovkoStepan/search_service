# frozen_string_literal: true

task load_products: :environment do
  LoadProducts.run
end
