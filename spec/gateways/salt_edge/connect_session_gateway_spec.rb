RSpec.describe SaltEdge::ConnectSessionGateway, type: :gateway do
  describe "#create" do
    subject {
      described_class.new.create(
        customer_id: customer.remote_id,
        from_date: from_date,
        period_days: period,
        callback_url: url
      )
    }

    let(:customer) { create(:customer, remote_id: "222222222222222222") }
    let(:from_date) { Date.current }
    let(:period) { 10 }
    let(:url) { "some_url" }

    let(:response_body) do
      {
        "data": {
          "expires_at": "2023-06-09T15:31:48Z",
          "connect_url": "https://www.saltedge.com/connect?token=GENERATED_TOKEN"
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
      request_body = {
        data: {
          customer_id: customer.remote_id,
          consent: {
            from_date: from_date,
            period_days: period,
            scopes: %w[account_details transactions_details]
          },
          attempt: {
            return_to: url
          }
        }
      }

      stub_request(:post, "https://www.saltedge.com/api/v5/connect_sessions/create")
        .with(body: request_body.to_json)
        .to_return(status: 200, body: response_body.to_json, headers: headers)
    end

    it "returns data with connect url" do
      expect(subject).to eq(response_body[:data])
    end
  end
end
