class Job < ApplicationRecord
  belongs_to :company
  belongs_to :category
  validates :title, :category_id, :company_id, :location, :description, presence: true

  def expired?
    created_at <= is_expire_date
  end

  def new?
    created_at >= is_new_date
  end

  private
  def is_expire_date
    90.days.ago
  end

  def is_new_date
    5.days.ago
  end
end
