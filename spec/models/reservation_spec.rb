require 'rails_helper'

RSpec.describe Reservation, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
	let(:user) { User.create(email: "listingtest321@mail.com", password:"123456") }
	let(:guest) { User.create(email: "guesttest321@mail.com", password:"123456") }
	let(:listing) { Listing.create(
		user_id: user.to_param,
		date_begin: "2016-05-12", 
		date_end: "2016-05-15", 
		title: "testing title", 
		description: "testing description", 
		price: 200.00)
	}
	let(:valid_params) { {
		user_id: user.to_param,
		listing_id: listing.to_param,
		date_in: "2016-05-12", 
		date_out: "2016-05-15"
	}}
	let(:invalid_params) { {
		user_id: user.to_param,
		listing_id: listing.to_param,
		date_in: "2016-06-15", 
		date_out: "2016-05-15"
	}}



  context "validations" do

  	it "should have all columns for listing details" do
  		should have_db_column(:date_in).of_type(:date)
  		should have_db_column(:date_out).of_type(:date)
  		should have_db_column(:total_price).of_type(:decimal)
  		should have_db_column(:user_id).of_type(:integer)
  		should have_db_column(:listing_id).of_type(:integer)
  	end

  	describe "validates presence of dates" do
  		it { is_expected.to validate_presence_of(:date_in) }
  		it { is_expected.to validate_presence_of(:date_out) }
  	end

  	#happy_path
  	describe "can be created when valid details present" do
  		When(:reservation) { Reservation.create(valid_params) }
  		Then { reservation.valid? == true }
  	end

  	#unhappy_path
  	describe "cannot create without check in date" do
  		When(:reservation) { Reservation.create(valid_params.except(:date_in)) }
  		Then { reservation.valid? == false }
  	end

  	describe "cannot create without check in date" do
  		When(:reservation) { Reservation.create(valid_params.except(:date_out)) }
  		Then { reservation.valid? == false }
  	end

  	describe "cannot create with check out date before check in date" do
  		When(:reservation) { Reservation.create(invalid_params) }
  		Then { reservation.valid? == false }
  	end

  end

  context "association with dependencies" do
  	it { is_expected.to belong_to(:user) }
  	it { is_expected.to belong_to(:listing) }
  	it { is_expected.to have_many(:payments).dependent(:destroy) }
  end
end

