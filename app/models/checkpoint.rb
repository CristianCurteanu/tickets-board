class Checkpoint < ApplicationRecord
  belongs_to :ticket

  validates :title, :rate_points, presence: :true

  before_save do
    self.rate_points = 0.to_f unless self.rate_points
  end
end
