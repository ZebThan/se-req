module Payouts
  module DatesHandlers
    class Range

      def self.get_dates(payload)
        since = payload[:since]
        to = payload[:to]
        [since, to]
      end
    end
  end
end