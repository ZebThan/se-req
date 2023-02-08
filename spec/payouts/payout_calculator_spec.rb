require 'spec_helper'
require "payouts/payout_calculator"

RSpec.describe ::Payouts::PayoutCalculator do
  subject { described_class }
  let(:merchant) { create(:merchant)}
  let(:week) { 1 }
  let(:year) { 2012 }

  before(:each) do
    create(:order, merchant_id: merchant.id, amount: 1000, completed_at: Date.commercial(year, week, 4)) #value after fee: 990
    create(:order, merchant_id: merchant.id, amount: 6000, completed_at: Date.commercial(year, week, 5)) #value after fee: 5943
    create(:order, merchant_id: merchant.id, amount: 40000, completed_at: Date.commercial(year, week, 5)) #value after fee: 39660
    
  end

  it 'returns correct value' do
    expected_value = 990 + 5943 + 39660 #expected fees from all orders
    expect(subject.payout_value(Order.all)).to eq(expected_value)
  end

  after(:each) do
    Merchant.destroy_all
    Order.destroy_all
    Payout.destroy_all
  end
end