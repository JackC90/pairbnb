require 'rails_helper'


RSpec.describe ListingsController, type: :controller do
	let(:user) { User.create(email: "listingtest321@mail.com", password:"123456", role: 2) }
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

	let(:listing) {Listing.new(
		user_id: user.to_param,
		date_begin: "2016-05-11", 
		date_end: "2016-06-12", 
		title: "testing title", 
		description: "testing description", 
		price: "100.00"
	)}

	before do
		sign_in_as user
	end

	describe "GET #index" do
		before do
			get "index"
		end

		it "returns http success" do
			expect(response).to have_http_status(:success)
		end

		it "renders the index template" do
			expect(response).to render_template("index")
		end
	end

	describe "GET #new" do
		before do
			get "new"
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
				expect(response).to redirect_to(listing_path(Listing.last))
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

	describe "GET #show" do
		before do
			get :edit, {:user_id => user.to_param, :id => listing.id}
		end
	end

	describe "GET #edit" do
		before do
			# session[:user_id] = user.id 
			get :show, {:user_id => user.to_param, :id => listing.id}
		end
	end

	describe "PUT #update" do
		#happy_path
		before do
			post :create, :listing => valid_params
			@edit = Listing.find_by(valid_params)
		end

		context "with valid params" do
			before do
				put :update, {:id => @edit.id , :listing => valid_params_update}
				@edit.reload
			end

			it "updates the requested listing details" do
				expect(@edit.title).to eq valid_params_update[:title]
			end

			it "redirects to listing path" do
				put :update, {:id => @edit.id, :listing => valid_params_update}
				@edit.reload
				expect(response).to redirect_to listing_path(@edit)
				expect(flash[:notice]).to eq "Listing is updated successfully."
			end
		end


		#unhappy_path
		context "with invalid_params" do
			before do
				put :update, {:id => @edit.id , :listing => invalid_params_update}
				@edit.reload
			end

			it "produces alert message" do
				expect(flash[:alert]).to eq "Error in updating listing."
			end

			it "redirects to edit page" do
				expect(response).to redirect_to edit_listing_path(@edit)
			end
		end
	end

	describe "DELETE #destroy" do
		before do
			post :create, listing: invalid_params
			@delete = user.listings.create(
				user_id: user.to_param,
				date_begin: "2016-05-12", 
				date_end: "2016-05-15", 
				title: "editing title", 
				description: "editing description", 
				price: 200.00
			)
		end

		it "deletes current listing" do
			expect {
				delete :destroy, {:id => @delete.id}
			}.to change(Listing, :count).by(-1)
		end

		it "redirects to listings_path" do
			delete :destroy, {:id => @delete.id}
			expect(response).to redirect_to listings_path
			expect(flash[:notice]).to eq "Listing is deleted"
		end
	end
end
