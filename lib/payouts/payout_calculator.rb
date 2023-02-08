module Payouts
  class PayoutCalculator

    def self.payout_value(orders)
      value = 0
      orders.each do |order|
        value = value + calculate_order_payout_value(order.amount)
      end
      return value
    end

    private

    def self.calculate_order_payout_value(value)
      (value - (value*fee_multiplier(value)))
    end

    def self.fee_multiplier(value) #multiplier values should be put in some config file
      multiplier =
      if value < 5000
        "0.01"
      elsif value < 30000
        "0.0095"
      else 
        "0.0085"
      end
      return BigDecimal(multiplier)
    end
    # This method is an alternative reverse solution, that uses integer dividers, instead non-integers multipliers. In general, BigDecimals
    # is safe and can be trusted, but there is also this aproach. I would discourage using it, as it introduces some additional math complexity.
    # Given numbers are probably a little off, as this serves only as an example of this reverse idea, which I personally find really
    # interesting.

    # def self.calculate_order_payout_value(order)
    #   (order.value - (order.value*1000000000/fee_divider(order.value)))
    # end
    # def self.fee_divider(value)
    #   return 100000000000 if value < 5000
    #   return 105263157895 if value < 30000
    #   return 117647058824
    # end
  end
end
