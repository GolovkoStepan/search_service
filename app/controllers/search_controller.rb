# frozen_string_literal: true

class SearchController < ApplicationController
  def search
    outcome = FindSearchResults.run(product: params[:product])

    if outcome.valid?
      render json: { status: :ok, data: outcome.result }
    else
      render json: { status: :error, messages: outcome.errors.full_messages }
    end
  end
end
