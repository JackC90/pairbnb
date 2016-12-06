require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  context "validations" do

  	it "should have email and password" do
  		should have_db_column(:email).of_type(:string)
  		should have_db_column(:encrypted_password).of_type(:string)
  	end

  	describe "validates presence and uniqeness of email" do
  		it { is_expected.to validate_presence_of(:email) }
  		it { is_expected.to validate_uniqueness_of(:email) }
  	end

  	describe "validates password" do
  		it { is_expected.to validate_presence_of(:password) }
  	end

  	# happy_path
  	describe "can be created when email and password present" do
  		When(:user) { User.create(
  			email: "test321@mail.com",
  			password: "123456"
  			) }
  		Then { user.valid? == true }
  	end

  	# unhappy_path
  	describe "cannot create without email" do
  		When(:user) { User.create(password: "123456") }
  		Then { user.valid? == false }
  	end

  	describe "cannot create without password" do
  		When(:user) { User.create(email: "test321@mail.com") }
  		Then { user.valid? == false }
  	end

  	describe "should only permit valid email" do
  		let(:valid_user) { User.create(email: "hello@mail.com", password: "123456") }
  		let(:invalid_user) { User.create(email: "hellomail.com", password: "123456") }

  		# happy_path
  		it "will sign up with valid email" do
  			expect(valid_user).to be_valid
  		end
  		
  		# unhappy_path
  		it "will not sign up with invalid email" do
  			expect(invalid_user).to be_invalid
  		end
  	end
  end

  	context "association with dependencies" do
  		it { is_expected.to have_many(:authentications).dependent(:destroy) }
  		it { is_expected.to have_many(:listings).dependent(:destroy) }
  		it { is_expected.to have_many(:reservations).dependent(:destroy) }
  		it { is_expected.to have_one(:profile).dependent(:destroy) }
  	end
end
