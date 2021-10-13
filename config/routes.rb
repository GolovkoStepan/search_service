# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'site#index'
  get '/search/:product', to: 'search#search', as: :search
end
