require 'spec_helper'
require "payouts/period_creator"

RSpec.describe ::Payouts::PeriodCreator do
  subject { described_class }
  let(:merchant) { create(:merchant)}
  let(:week) { 1 }
  let(:year) { 2012 }

  before(:each) do
    create(:order, merchant_id: merchant.id, amount: 10, completed_at: Date.commercial(year, week, 4))
    create(:order, merchant_id: merchant.id, amount: 20, completed_at: Date.commercial(year, week, 5))
  end

  it 'calls create on Payout correctly' do
    expected_value = 42
    Payouts::PayoutCalculator.should_receive(:payout_value).with(merchant.orders).and_return(expected_value)
    Payout.should_receive(:create).with({merchant_id: merchant.id, value: expected_value, for_week: week})
    subject.new(payload: { week: week, year: year }).call
  end

  it 'returns error when no mode support' do
    expect { subject.new(mode: :non_existent).call }.to raise_error("Unknown mode non_existent. Allowed modes: by_week")
  end

  after(:each) do # seems that transactions for examples do not work, so I'm manually clearing it
    Merchant.destroy_all
    Order.destroy_all
    Payout.destroy_all
  end
end