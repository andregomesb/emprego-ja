class Job < ApplicationRecord
  belongs_to :company

  validates :title, :category, :company, :location, :description, presence: true
end
