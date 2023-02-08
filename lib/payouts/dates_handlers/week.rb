module Payouts
  module DatesHandlers
    class Week

      # this logic would require additional check how it will work on a weeks that overlaps two years
      def self.get_dates(payload)
        since = Date.commercial(payload[:year], payload[:week], 1)
        to = Date.commercial(payload[:year], payload[:week], 7)
        [since, to, {for_week: payload[:week]}]
      end
    end
  end
end