# frozen_string_literal: true

class SiteController < ApplicationController
  def index
    render plain: 'Search Service'
  end
end
