FactoryGirl.define do
  factory :job do
    title 'Dev Master'
    location 'Rio de Janeiro'
    description 'Vaga para Dev Master para Bootcamp Rails'
    company
    category

    factory :jobs do
      sequence(:title) {|n| "Slave Developer #{n}"}
    end
  end
end
