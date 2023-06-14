RSpec.describe CustomersController, type: :controller do
  let(:user) { create(:user) }

  before { sign_in(user) }

  context "POST /customers" do
    before do
      allow_any_instance_of(SaltEdge::CustomerGateway).to receive(:create)
        .with(user.email)
        .and_return(customer_response)
    end

    context "when API work" do
      let(:customer_response) do
        {
          "id": "222222222222222222",
          "identifier": user.email,
          "secret": "AtQX6Q8vRyMrPjUVtW7J_O1n06qYQ25bvUJ8CIC80-8",
          "blocked_at": "2021-03-15T09:43:01Z",
          "created_at": "2020-03-12T09:20:01Z",
          "updated_at": "2020-03-12T09:20:01Z"
        }
      end

      it "creates customer" do
        expect { post :create }.to change(Customer, :count).by(1)
      end

      it "redirects to home" do
        post :create
        expect(response).to redirect_to(home_index_path)
      end
    end

    context "when API not work" do
      let(:customer_response) do
        {
          "error": {
            "class": "ConnectionNotFound",
            "message": "Connection with id: '111111111111111111' was not found."
          }
        }
      end

      it "doesn't create customer" do
        expect { post :create }.not_to change(Customer, :count)
      end

      it "redirects to home" do
        post :create
        expect(response).to redirect_to(home_index_path)
      end
    end
  end
end