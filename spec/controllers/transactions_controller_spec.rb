RSpec.describe TransactionsController, type: :controller do
  let(:user) { create(:user) }
  let(:customer) { create(:customer, user: user, remote_id: "1111") }
  let(:connection) { create(:connection, customer: customer, remote_id: "22222") }
  let(:account) { create(:account, connection: connection, remote_id: "333333") }

  before { sign_in(user) }

  context "GET /connections/:connection_id/accounts/:account_id/transactions" do
    before do
      allow_any_instance_of(SaltEdge::TransactionGateway).to receive(:get_list)
        .with(
          connection_id: connection.remote_id,
          account_id: account.remote_id,
          from_id: nil
        )
        .and_return(api_response)
    end

    context "when API work" do
      context "with fetch remote param" do
        let(:api_response) do
          [
            {
              "id": "444444444444444444",
              "duplicated": false,
              "mode": "normal",
              "status": "posted",
              "made_on": "2020-05-03",
              "amount": -200.0,
              "currency_code": "USD",
              "description": "test transaction",
              "category": "advertising",
              "extra": {
                "original_amount": -3974.6,
                "original_currency_code": "CZK",
                "posting_date": "2020-05-07",
                "time": "23:56:12"
              },
              "account_id": "333333333333333333",
              "created_at": "2023-06-07T14:31:49Z",
              "updated_at": "2023-06-08T14:31:49Z"
            },
            {
              "id": "444444444444444445",
              "duplicated": false,
              "mode": "normal",
              "status": "posted",
              "made_on": "2020-05-03",
              "amount": 50.0,
              "currency_code": "USD",
              "description": "business expense",
              "category": "business_services",
              "extra": {
                "original_amount": 993.9,
                "original_currency_code": "CZK",
                "posting_date": "2020-05-06",
                "time": "12:16:25"
              },
              "account_id": "333333333333333333",
              "created_at": "2023-06-07T14:31:49Z",
              "updated_at": "2023-06-08T14:31:49Z"
            }
          ]
        end

        it "calls gateway" do
          expect_any_instance_of(SaltEdge::TransactionGateway).to receive(:get_list)
          get(:index, params: {connection_id: connection.id, account_id: account.id, fetch_remote: true})
        end

        it "creates transactions" do
          expect { get(:index, params: {connection_id: connection.id, account_id: account.id, fetch_remote: true}) }
            .to change(Transaction, :count).by(2)
        end

        it "responds successful" do
          get(:index, params: {connection_id: connection.id, account_id: account.id, fetch_remote: true})
          expect(response).to be_successful
        end
      end

      context "without fetch remote param" do
        let(:api_response) { {} }

        it "doesn't call gateway" do
          expect_any_instance_of(SaltEdge::TransactionGateway).not_to receive(:get_list)
          get(:index, params: {connection_id: connection.id, account_id: account.id})
        end

        it "doesn't create transactions" do
          expect { get(:index, params: {connection_id: connection.id, account_id: account.id}) }
            .not_to change(Transaction, :count)
        end

        it "responds successful" do
          get(:index, params: {connection_id: connection.id, account_id: account.id})
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

      it "doesn't create transactions" do
        expect { get(:index, params: {connection_id: connection.id, account_id: account.id, fetch_remote: true}) }
          .not_to change(Transaction, :count)
      end

      it "responds successful" do
        get(:index, params: {connection_id: connection.id, account_id: account.id, fetch_remote: true})
        expect(response).to be_successful
      end
    end
  end
end