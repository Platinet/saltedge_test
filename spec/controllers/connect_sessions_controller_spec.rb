RSpec.describe ConnectSessionsController, type: :controller do
  let(:user) { create(:user) }
  let(:customer) { create(:customer, user: user, remote_id: "1111") }

  before { sign_in(user) }

  context "POST /connect_sessions" do
    before do
      allow_any_instance_of(SaltEdge::ConnectSessionGateway).to receive(:create)
        .with(
          customer_id: customer.remote_id,
          from_date: Date.current.iso8601,
          period_days: 10,
          callback_url: home_index_url
        )
        .and_return(api_response)
    end

    context "when API work" do
      let(:api_response) do
        {
          "expires_at": "2023-06-09T15:31:48Z",
          "connect_url": "https://www.saltedge.com/connect?token=GENERATED_TOKEN"
        }
      end

      it "creates connect session" do
        expect { post :create }.to change(ConnectSession, :count).by(1)
      end

      it "redirects to home" do
        post :create
        expect(response).to redirect_to(home_index_path)
      end
    end

    context "when API not work" do
      let(:api_response) do
        {
          "error": {
            "class": "ConnectionNotFound",
            "message": "Connection with id: '111111111111111111' was not found."
          }
        }
      end

      it "doesn't create connect session" do
        expect { post :create }.not_to change(ConnectSession, :count)
      end

      it "redirects to home" do
        post :create
        expect(response).to redirect_to(home_index_path)
      end
    end
  end
end