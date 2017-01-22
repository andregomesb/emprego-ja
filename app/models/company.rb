class Company < ApplicationRecord
  has_many :jobs
  validates :name, :location, :phone, :mail, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  PREMIUM = 5

  def premium?
    jobs.size >= PREMIUM
  end
end
