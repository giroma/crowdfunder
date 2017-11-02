class Reward < ActiveRecord::Base
  has_many :claims

  belongs_to :project

  validates :description, :dollar_amount, presence: true
  validate :must_be_positive

  def must_be_positive
    if dollar_amount.present? && dollar_amount < 0
      errors.add(:dollar_amount, "Project's goal must be positive number")
    end
  end
end
