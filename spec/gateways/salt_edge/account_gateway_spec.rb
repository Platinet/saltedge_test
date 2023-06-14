RSpec.describe SaltEdge::AccountGateway, type: :gateway do
  describe "#get_list" do
    subject { described_class.new.get_list(connection_id: connection.remote_id) }

    let(:connection) { create(:connection, remote_id: "111111111111111111") }
    let(:response_body) do
      {
        "data": [
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
        ],
        "meta": {
          "next_id": "333333333333333335",
          "next_page": "/api/v5/accounts?connection_id=111111111111111111"
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
      stub_request(:get, "https://www.saltedge.com/api/v5/accounts?connection_id=111111111111111111&from_id=")
        .to_return(status: 200, body: response_body.to_json, headers: headers)
    end

    it "returns array of data" do
      expect(subject).to eq(response_body[:data])
    end
  end
end