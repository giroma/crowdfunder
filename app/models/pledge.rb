class Pledge < ApplicationRecord
  belongs_to :user
  belongs_to :project



  validates :dollar_amount, presence: true
  validates :user, presence: true
  validate :owner_cannot_back_own_project

  def owner_cannot_back_own_project
    if project.user == user
      errors.add(:user, 'You can not back your own project')
    end
  end
end
