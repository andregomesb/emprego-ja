class Job < ApplicationRecord
  belongs_to :company
  belongs_to :category
  validates :title, :category_id, :company_id, :location, :description, presence: true
  EXPIRE_DATE = 90
  NEW_JOB_DATE = 5

  def expired?
    created_at <= EXPIRE_DATE.days.ago
  end

  def new?
    created_at >= NEW_JOB_DATE.days.ago
  end
end
