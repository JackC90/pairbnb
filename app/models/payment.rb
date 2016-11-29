class Payment < ApplicationRecord
  belongs_to :reservation
  validates :reservation_id, uniqueness: true
end
