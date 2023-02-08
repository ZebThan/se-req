module Payouts
  class PeriodCreator
    # this class can be put in background job, run in the console, rails task or whatever the current need is

    attr_reader :since, :to, :merchants, :payout_params

    # In current state only :by_week mode is fully supported, because Payout model requires week number to 
    # have any buisness value. However this class is extendable if needed, and should require minimal changes.
    MODES_MAP = {
      by_week: Payouts::DatesHandlers::Week,
      # by_range: Payouts::DatesHandlers::Range,
    }

    def initialize(payload: nil, mode: :by_week, merchants: Merchant.all)
      raise "Unknown mode #{mode}. Allowed modes: #{MODES_MAP.keys.join(", ")}" unless MODES_MAP.keys.include?(mode)
      @since, @to, @payout_params = MODES_MAP[mode].get_dates(payload)
      @merchants = merchants
    end

    # Performance can be improved by storing fee on the order, to avoid calculating it for every single orders set
    # and instead using database to sum up all the fees and return them all in in a single query.
    # However this requires keeping track of the stored values and making sure they are all correct.
    def call
      merchants.each do |merchant|
        orders = merchant.orders.where("completed_at > ? AND completed_at < ?", since, to)
        value = Payouts::PayoutCalculator.payout_value(orders)
        Payout.create({merchant_id: merchant.id, value: value}.merge(payout_params))
      end
    end

  end
end