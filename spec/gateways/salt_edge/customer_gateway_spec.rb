RSpec.describe SaltEdge::CustomerGateway, type: :gateway do
  describe "#create" do
    subject { described_class.new.create(user.email) }

    let(:user) { create(:user) }

    let(:response_body) do
      {
        "data": {
          "id": "222222222222222222",
          "identifier": user.email,
          "secret": "AtQX6Q8vRyMrPjUVtW7J_O1n06qYQ25bvUJ8CIC80-8",
          "blocked_at": "2021-03-15T09:43:01Z",
          "created_at": "2020-03-12T09:20:01Z",
          "updated_at": "2020-03-12T09:20:01Z"
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
          identifier: user.email
        }
      }
      stub_request(:post, "https://www.saltedge.com/api/v5/customers")
        .with(body: request_body.to_json)
        .to_return(status: 200, body: response_body.to_json, headers: headers)
    end

    it "returns customer data" do
      expect(subject).to eq(response_body[:data])
    end
  end
end