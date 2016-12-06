require 'rails_helper'

RSpec.describe Listing, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  let(:user) { User.create(email: "listingtest321@mail.com", password:"123456") }
  let(:valid_params) {{
  	user_id: user.to_param,
  	date_begin: "2016-05-12", 
  	date_end: "2016-05-15", 
  	title: "testing title", 
  	description: "testing description", 
  	price: 200.00
  	}}

  context "validations" do
  	it "should have all columns for listing details" do
  		should have_db_column(:date_begin).of_type(:date)
  		should have_db_column(:date_end).of_type(:date)
  		should have_db_column(:title).of_type(:string)
  		should have_db_column(:description).of_type(:text)
  		should have_db_column(:price).of_type(:decimal)
  	end

  	describe "validates presence of dates" do
  		it { is_expected.to validate_presence_of(:date_begin) }
  		it { is_expected.to validate_presence_of(:date_end) }
  	end

  	describe "validates presence of title" do
  		it { is_expected.to validate_presence_of(:title) }
  	end 

  	#happy_path
  	describe "can be created when valid details present" do
  		When(:listing) { Listing.create(valid_params) }
  		Then { listing.valid? == true }
  	end

  	#unhappy_path
  	describe "cannot create without dates" do
  		When(:listing) { Listing.create(valid_params.except(:date_begin)) }
  		Then { listing.valid? == false }
  	end

  	describe "cannot create without title" do
  		When(:listing) { Listing.create(valid_params.except(:title)) }
  		Then { listing.valid? == false }
  	end

  	describe "cannot create without description" do
  		When(:listing) { Listing.create(valid_params.except(:description)) }
  		Then { listing.valid? == false }
  	end

  	describe "cannot create without price" do
  		When(:listing) { Listing.create(valid_params.except(:price)) }
  		Then { listing.valid? == false }
  	end
  end

  context "association with dependencies" do
  	it { is_expected.to belong_to(:user) }
  	it { is_expected.to have_many(:reservations).dependent(:destroy) }
  	it { is_expected.to have_one(:amenity).dependent(:destroy) }
  end
end
