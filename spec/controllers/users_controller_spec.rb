require 'rails_helper'

RSpec.describe UsersController, type: :controller do
	let(:valid_params) {{email: "test321@mail.com", password: "123456"}}
	let(:invalid_params) {{email: "test321mail.com", password: "123456"}}
	let(:valid_params_update) {{email: "newtest@321@mail.com", password: "123456"}}
	let(:invalid_params_update) {{email: "newtest321@mail.com", password: "123456"}}

	let(:user) { User.create(valid_params) }
	let(:user1) { User.create(email: "someone@mail.com", password: "123456") }
	
	describe "GET #new" do
		before do
			get "users/new"
		end

		it "returns http success" do
			expect(response).to have_http_status(:success)
		end

		it "renders the new template" do
			expect(response).to render_template("users/new")
		end

	end

	describe "POST #create" do
		#happy_path
		context "valid_params" do
			it "creates new user if params valid" do
				expect {post :create, :user => valid_params}.to change(User, :count).by(1)	
			end

			it "redirects to user profile" do
				post :create, user: valid_params
				expect(response).to redirect_to(listings_path)
				expect(flash[:notice]).to eq "Account created."
			end
		end

		#unhappy_path
		context "invalid_params" do
			before do 
				post :create, user: invalid_params
			end

			it "displays flash alert message" do
				expect(flash[:alert]).to include "Error creating account."
			end

			it "renders new template" do
				expect(response).to render_template("sign_up")
			end
		end
	end

	describe "GET #edit" do
		before do
			session[:user_id] = user.id 
			get :edit, {:id => user.to_param}
		end
	end

	describe "PUT #update" do
		#happy_path
		context "with valid params" do
			it "updates the requested user signin details" do
				user = user1
				put :update, {:id => user.to_param, :user => valid_params_update}
				user.reload
				expect(user.email).to eq valid_params_update[:email]
			end

			it "redirects to user path" do
				user = user1
				put :update, {:id => user.to_param, :user => valid_params_update}
				user.reload
				expect(response).to redirect_to listings_path
				expect(flash[:notice]).to eq "Account is updated successfully."
			end
		end

		#unhappy_path
		context "with invalid_params" do
			it "produces alert message" do
				put :update, {:id => user.to_param, :user => invalid_params_update}
				user.reload
				expect(flash[:alert]).to eq "Error in updating account."
			end

			it "redirects to edit page" do
				put :update, {:id => user.to_param, :user => invalid_params_update}
				user.reload
				expect(response).to redirect_to edit_user_path(user)
			end
		end
	end

	describe "DELETE #destroy" do
		it "deletes current user" do
			user = user1
			expect {
				delete :destroy, {:id => user.to_param}
			}.to change(User, :count).by(-1)
		end

		it "redirects to listings_path" do
			user = user1
			delete :destroy, {:id => user.to_param}
			expect(response).to redirect_to listings_path
			expect(flash[:notice]).to eq "Account is deleted"
		end
	end
end
