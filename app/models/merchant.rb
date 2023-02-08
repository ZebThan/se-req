class Merchant < ApplicationRecord
  has_many :payouts
  has_many :orders
end