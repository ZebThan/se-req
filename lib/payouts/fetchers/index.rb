module Payouts
  module Fetchers
    class Index

      attr_reader :merchant_id, :week, :year

      def initialize(filters)
        @merchant_id = filters[:merchant_id]
        @week = filters[:week]
        @year = filters[:year]
      end

      def call
        query = Payout.all
        query = filter_merchants(query) if merchant_id
        query = filter_weeks(query) if week
        query = filter_years(query) if year
        query
      end

      private

      def filter_merchants(query)
        query.where(merchant_id: merchant_id)
      end

      def filter_weeks(query)
        query.where(for_week: week)
      end

      def filter_years(query)
        query.where(for_year: year)
      end
    end
  end
end