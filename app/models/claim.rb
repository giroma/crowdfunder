class Claim < ApplicationRecord
  belongs_to :project
  belongs_to :reward
  belongs_to :user
end
