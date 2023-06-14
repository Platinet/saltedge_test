RSpec.describe SaltEdge::TransactionGateway, type: :gateway do
  describe "#create" do
    subject { described_class.new.get_list(connection_id: connection.remote_id, account_id: account.remote_id, from_id: nil) }

    let(:connection) { create(:connection, remote_id: "111111111111111111") }
    let(:account) { create(:account, connection: connection, remote_id: "333333333333333333") }

    let(:response_body) do
      {
        "data": [
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
        ],
        "meta": {
          "next_id": "444444444444444446",
          "next_page": "/api/v5/transactions/?connection_id=111111111111111111&account_id=333333333333333333&from_id="
        }
      }
    end
    let(:headers) do
      {
        "Accept" => "application/json",
        "Content-Type" => "application/json",
        "App-id" => "#{Rails.configuration.salt_edge_app_id}",
        "Secret" => "#{Rails.configuration.salt_edge_secret}"
      }
    end

    before do

      stub_request(:get, "https://www.saltedge.com/api/v5/transactions?account_id=333333333333333333&connection_id=111111111111111111&from_id=")
        .to_return(status: 200, body: response_body.to_json, headers: headers)
    end

    it "returns list of transactions" do
      expect(subject).to eq(response_body[:data])
    end
  end
end