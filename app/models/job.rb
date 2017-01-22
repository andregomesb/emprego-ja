class Job < ApplicationRecord

  belongs_to :company
  belongs_to :category
  validates :title, :category_id, :company_id, :location, :description, presence: true

  def expired?
    created_at <= expire_date
  end

  private
  # using constant (EXPIRE_DATE) was causing the 'rspec' test fail,
  # but the 'rspec/model' pass. Decided to go with method instead.
  def expire_date
    90.days.ago
  end
end
