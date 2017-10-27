class Pledge < ApplicationRecord
  belongs_to :user
  belongs_to :project



  validates :dollar_amount, presence: true
  validates :user, presence: true
  validate :owner_cannot_back_own_project
  validate :must_be_positive


  def owner_cannot_back_own_project
    if project.user == user
      errors.add(:user_id, "Owner can\'t pledge")
    end
  end

  def must_be_positive
    if dollar_amount.present? && dollar_amount < 0
      errors.add(:dollar_amount, "Dollar amount must be positive number")
    end
  end
end
