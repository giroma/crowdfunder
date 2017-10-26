class Pledge < ApplicationRecord
  belongs_to :user
  belongs_to :project



  validates :dollar_amount, presence: true
  validates :user, presence: true
<<<<<<< HEAD
  validate :owner_cannot_back_own_project

  def owner_cannot_back_own_project
    if project.user == user
      errors.add(:user_id, 'You can not back your own project')

=======
  validate :owner_cant_pledge


  def owner_cant_pledge
    if project.user == user
      errors.add(:user_id, "Owner cant pledge")
>>>>>>> 4890b320ac7f68151f121611ad4857ee428dfd68
    end
  end
end
