class Company < ApplicationRecord
  PREMIUM = 5
  has_many :jobs

  def premium?
    jobs.size >= PREMIUM
  end
end
