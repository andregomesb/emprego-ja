class Company < ApplicationRecord
  PREMIUM = 5
  has_many :jobs
  validates :name, :location, :phone, :mail, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  def premium?
    jobs.size >= PREMIUM
  end
end
