FactoryBot.define do
  factory :merchant do
    name { 'Test' }
    email {'test@test.com '}
    cif {'test'}
  end
end

FactoryBot.define do
  factory :order do
  end
end