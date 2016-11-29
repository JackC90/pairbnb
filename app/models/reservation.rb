class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :listing
  has_many 	 :payments
  validates :date_in, presence: true
  validates :date_out, presence: true, date: {after_or_equal_to: :date_in, message: "End date must be after start date. Please choose another date." }
  # validates :date_in, :date_out, overlap: true

  def made_reservations?
  	Reservation.exists?(listing_id: params[:listing_id], user_id: current_user.id)
  end		
end
