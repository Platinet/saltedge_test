RSpec.describe AccountsController, type: :controller do
  let(:user) { create(:user) }
  let(:customer) { create(:customer, user: user, remote_id: "1111") }
  let(:connection) { create(:connection, customer: customer, remote_id: "22222") }

  before { sign_in(user) }

  context "GET /connections/:connection_id/accounts" do
    before do
      allow_any_instance_of(SaltEdge::AccountGateway).to receive(:get_list)
        .with(
          connection_id: connection.remote_id,
          from_id: nil
        )
        .and_return(api_response)
    end

    context "when API work" do
      context "with fetch remote param" do
        let(:api_response) do
          [
            {
              "id": "333333333333333333",
              "name": "Fake account 1",
              "nature": "card",
              "balance": 2007.2,
              "currency_code": "EUR",
              "extra": {
                "client_name": "Fake name"
              },
              "connection_id": "111111111111111111",
              "created_at": "2023-06-09T11:31:49Z",
              "updated_at": "2023-06-09T11:31:49Z"
            },
            {
              "id": "333333333333333334",
              "name": "Fake account 2",
              "nature": "account",
              "balance": 2012.7,
              "currency_code": "USD",
              "extra": {
                "cards": %w[1234....5678 *8765],
                "transactions_count": {
                  "posted": 22,
                  "pending": 1
                }
              },
              "connection_id": "111111111111111111",
              "created_at": "2023-06-09T12:31:49Z",
              "updated_at": "2023-06-09T12:31:49Z"
            }
          ]
        end

        it "calls gateway" do
          expect_any_instance_of(SaltEdge::AccountGateway).to receive(:get_list)
          get(:index, params: {connection_id: connection.id, fetch_remote: true})
        end

        it "creates accounts" do
          expect { get(:index, params: {connection_id: connection.id, fetch_remote: true}) }.to change(Account, :count).by(2)
        end

        it "responds successful" do
          get(:index, params: {connection_id: connection.id, fetch_remote: true})
          expect(response).to be_successful
        end
      end

      context "without fetch remote param" do
        let(:api_response) { {} }

        it "doesn't call gateway" do
          expect_any_instance_of(SaltEdge::AccountGateway).not_to receive(:get_list)
          get(:index, params: {connection_id: connection.id})
        end

        it "doesn't create accounts" do
          expect { get(:index, params: {connection_id: connection.id}) }.not_to change(Account, :count)
        end

        it "responds successful" do
          get(:index, params: {connection_id: connection.id})
          expect(response).to be_successful
        end
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

      it "doesn't create accounts" do
        expect { get(:index, params: {connection_id: connection.id, fetch_remote: true}) }.not_to change(Account, :count)
      end

      it "responds successful" do
        get(:index, params: {connection_id: connection.id, fetch_remote: true})
        expect(response).to be_successful
      end
    end
  end
end