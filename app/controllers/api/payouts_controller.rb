module Api
  class PayoutsController < ApplicationController

    def index
      payouts = Payouts::Fetchers::Index.new(params.slice(:merchant_id, :week, :year)).call

      render json: payouts
    end
    
  end
end