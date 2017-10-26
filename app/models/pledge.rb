class Pledge < ApplicationRecord
  belongs_to :user
  belongs_to :project



  validates :dollar_amount, presence: true
  validates :user, presence: true
  validate :owner_cant_pledge


  def owner_cant_pledge
    if project.user == user
      errors.add(:user_id, "Owner cant pledge")
    end
  end
end
