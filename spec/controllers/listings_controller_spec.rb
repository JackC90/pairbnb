require 'rails_helper'

RSpec.describe ListingsController, type: :controller do
	let(:user) { User.create(email: "listingtest321@mail.com", password:"123456") }
	let(:valid_params) {{
		user_id: user.to_param,
		date_begin: "2016-05-12", 
		date_end: "2016-05-15", 
		title: "testing title", 
		description: "testing description", 
		price: 200.00
	}}

	let(:invalid_params) {{
		user_id: user.to_param,
		date_begin: "", 
		date_end: "2016-05-15", 
		title: "testing title", 
		description: "testing description", 
		price: 200.00
	}}

	let(:valid_params_update) {{
		user_id: user.to_param,
		date_begin: "2016-05-12", 
		date_end: "2016-05-15", 
		title: "new testing title", 
		description: "testing description", 
		price: 200.00
	}}

	let(:invalid_params_update) {{
		user_id: user.to_param,
		date_begin: "2016-05-12", 
		date_end: "2016", 
		title: "testing title", 
		description: "testing description", 
		price: "200.00"
	}}

	describe "GET #new"
		before do
			get "listings/new"
		end

		it "returns http success" do
			expect(response).to have_http_status(:success)
		end

		it "renders the new template" do
			expect(response).to render_template("listings/new")
		end

	end

	describe "POST #create" do
		#happy_path
		context "valid_params" do
			it "creates new listing if params valid" do
				expect {post :create, :listing => valid_params}.to change(Listing, :count).by(1)	
			end

			it "redirects to listings" do
				post :create, listing: valid_params
				expect(response).to redirect_to(listings_path)
				expect(flash[:notice]).to eq "Listing created."
			end
		end

		#unhappy_path
		context "invalid_params" do
			before do 
				post :create, listing: invalid_params
			end

			it "displays flash alert message" do
				expect(flash[:alert]).to include "Error creating listing."
			end

			it "renders new template" do
				expect(response).to render_template("listings/new")
			end
		end
	end

	describe "GET #edit" do
		before do
			session[:user_id] = user.id 
			get :edit, {:user_id => user.to_param, }
		end
	end

	describe "PUT #update" do
		#happy_path
		context "with valid params" do
			it "updates the requested user signin details" do
				put :update, {:id => Listing.last.id , :listing => valid_params_update}
				listing.reload
				expect(user.email).to eq valid_params_update[:title]
			end

			it "redirects to user path" do
				user = user1
				put :update, {:id => user.to_param, :user => valid_params_update}
				user.reload
				expect(response).to redirect_to listings_path
				expect(flash[:notice]).to eq "Listing is updated successfully."
			end
		end

		#unhappy_path
		context "with invalid_params" do
			it "produces alert message" do
				put :update, {:id => Listing.last.id , :listing => invalid_params_update}
				listing.reload
				expect(flash[:alert]).to eq "Error in updating listing."
			end

			it "redirects to edit page" do
				put :update, {:id => Listing.last.id, :listing => invalid_params_update}
				user.reload
				expect(response).to redirect_to edit_listing_path(user)
			end
		end
	end

	describe "DELETE #destroy" do
		it "deletes current listing" do
			expect {
				delete :destroy, {:id => Listing.last.id}
			}.to change(Listing, :count).by(-1)
		end

		it "redirects to listings_path" do
			delete :destroy, {:id => Listing.last.id}
			expect(response).to redirect_to listings_path
			expect(flash[:notice]).to eq "Listing is deleted"
		end
	end
end
