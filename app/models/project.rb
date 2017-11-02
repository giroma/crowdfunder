class Project < ActiveRecord::Base
  has_many :rewards
  has_many :pledges
  has_many :comments
  has_many :claims
  has_many :owner_updates
  has_many :users, through: :pledges # backers
  belongs_to :user # project owner
  belongs_to :category

  validates :user_id, presence: true
  validates :title, :description, :goal, :start_date, :end_date, presence: true
  # validate :project_start_date_must_be_in_the_future
  # validate :project_end_date_must_be_in_the_future
  validate :must_be_positive

  def project_start_date_must_be_in_the_future
    if start_date < Date.today
      errors.add(:start_date, "Start date must be in the future.")
    end
  end

  def project_end_date_must_be_in_the_future
    if end_date < Date.today
      errors.add(:start_date, "End date must be in the future.")
    end
  end

  def must_be_positive
    if goal <= 0
      errors.add(:goal, "Project's goal must be positive number")
    end
  end
end
