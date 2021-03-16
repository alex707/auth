FactoryBot.define do
  sequence(:name) do |n|
    "user#{n}_name"
  end

  sequence(:email) do |n|
    "user#{n}@email.com"
  end
end
