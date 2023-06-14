RSpec.describe SaltEdge::ConnectionGateway, type: :gateway do
  describe "#get_list" do
    subject { described_class.new.get_list(customer_id: customer.remote_id) }

    let(:customer) { create(:customer, remote_id: "222222222222222222") }

    let(:response_body) do
      {
        "data": [
          {
            "country_code": "XF",
            "created_at": "2023-06-08T14:31:48Z",
            "customer_id": "222222222222222222",
            "daily_refresh": false,
            "id": "111111111111111111",
            "secret": "AtQX6Q8vRyMrPjUVtW7J_O1n06qYQ25bvUJ8CIC80-8",
            "show_consent_confirmation": false,
            "last_consent_id": "555555555555555555",
            "last_attempt": {
              "api_mode": "service",
              "api_version": "5",
              "automatic_fetch": true,
              "user_present": false,
              "daily_refresh": false,
              "categorization": "personal",
              "created_at": "2023-06-09T13:51:48Z",
              "customer_last_logged_at": "2023-06-09T11:31:48Z",
              "custom_fields": {
              },
              "device_type": "desktop",
              "remote_ip": "93.184.216.34",
              "exclude_accounts": [

              ],
              "fail_at": nil,
              "fail_error_class": nil,
              "fail_message": nil,
              "fetch_scopes": %w[accounts transactions],
              "finished": true,
              "finished_recent": true,
              "from_date": nil,
              "id": "777777777777777777",
              "interactive": false,
              "locale": "en",
              "partial": false,
              "store_credentials": true,
              "success_at": "2023-06-09T13:51:48Z",
              "to_date": nil,
              "updated_at": "2023-06-09T13:51:48Z",
              "show_consent_confirmation": false,
              "consent_id": "555555555555555555",
              "include_natures": %w[account card bonus],
              "last_stage": {
                "created_at": "2023-06-09T13:51:48Z",
                "id": "888888888888888888",
                "interactive_fields_names": nil,
                "interactive_html": nil,
                "name": "finish",
                "updated_at": "2023-06-09T13:51:48Z"
              }
            },
            "last_success_at": "2023-06-09T13:51:48Z",
            "next_refresh_possible_at": "2023-06-09T15:31:48Z",
            "provider_id": "1234",
            "provider_code": "fakebank_simple_xf",
            "provider_name": "Fakebank Simple",
            "status": "active",
            "store_credentials": true,
            "updated_at": "2023-06-09T13:51:48Z"
          }
        ],
        "meta": {
          "next_id": "111111111111111112",
          "next_page": "/api/v5/connections?customer_id=222222222222222222&from_id="
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
      stub_request(:get, "https://www.saltedge.com/api/v5/connections?customer_id=#{customer.remote_id}&from_id=")
        .to_return(status: 200, body: response_body.to_json, headers: headers)
    end

    it "returns list of connections" do
      expect(subject).to eq(response_body[:data])
    end
  end

  describe "#show" do
    subject { described_class.new.show(connection_id: connection.remote_id) }

    let(:connection) { create(:connection, remote_id: "111111111111111111") }

    let(:response_body) do
      {
        "data": {
          "country_code": "MD",
          "created_at": "2020-05-07T20:09:02Z",
          "customer_id": "222222222222222222",
          "daily_refresh": false,
          "id": "111111111111111111",
          "secret": "AtQX6Q8vRyMrPjUVtW7J_O1n06qYQ25bvUJ8CIC80-8",
          "show_consent_confirmation": false,
          "last_consent_id": "555555555555555555",
          "last_attempt": {
            "api_mode": "service",
            "api_version": "5",
            "automatic_fetch": true,
            "user_present": false,
            "daily_refresh": false,
            "categorization": "personal",
            "created_at": "2020-05-07T16:14:53Z",
            "customer_last_logged_at": "2023-06-09T11:31:48Z",
            "custom_fields": {
            },
            "device_type": "desktop",
            "remote_ip": "93.184.216.34",
            "exclude_accounts": [

            ],
            "fail_at": nil,
            "fail_error_class": nil,
            "fail_message": nil,
            "fetch_scopes": %w[accounts transactions],
            "finished": true,
            "finished_recent": true,
            "from_date": nil,
            "id": "777777777777777777",
            "interactive": false,
            "locale": "en",
            "partial": false,
            "store_credentials": true,
            "success_at": "2020-06-02T16:16:19Z",
            "to_date": nil,
            "updated_at": "2020-06-02T16:16:19Z",
            "show_consent_confirmation": false,
            "consent_id": "555555555555555555",
            "include_natures": %w[account card bonus],
            "last_stage": {
              "created_at": "2020-06-02T16:16:19Z",
              "id": "888888888888888888",
              "interactive_fields_names": nil,
              "interactive_html": nil,
              "name": "finish",
              "updated_at": "2020-06-02T16:16:19Z"
            }
          },
          "last_success_at": "2020-06-02T16:16:19Z",
          "next_refresh_possible_at": "2020-06-02T17:16:19Z",
          "provider_id": "1234",
          "provider_code": "moldindconbank_wb_md",
          "provider_name": "Moldindconbank Web Banking",
          "status": "active",
          "store_credentials": true,
          "updated_at": "2020-06-02T09:41:23Z"
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
      stub_request(:get, "https://www.saltedge.com/api/v5/connections/111111111111111111")
        .to_return(status: 200, body: response_body.to_json, headers: headers)
    end

    it "returns connection data" do
      expect(subject).to eq(response_body[:data])
    end
  end

  describe "#create" do
    subject { described_class.new.create(customer_id: customer.remote_id, from_date: from_date, user: customer.user) }

    let(:customer) { create(:customer, remote_id: "222222222222222222") }
    let(:from_date) { Date.current }

    let(:response_body) do
      {
        "data": {
          "country_code": "MD",
          "created_at": "2020-05-07T20:09:02Z",
          "customer_id": "222222222222222222",
          "daily_refresh": false,
          "id": "111111111111111111",
          "secret": "AtQX6Q8vRyMrPjUVtW7J_O1n06qYQ25bvUJ8CIC80-8",
          "show_consent_confirmation": false,
          "last_consent_id": "555555555555555555",
          "last_attempt": {
            "api_mode": "service",
            "api_version": "5",
            "automatic_fetch": true,
            "user_present": false,
            "daily_refresh": false,
            "categorization": "personal",
            "created_at": "2020-05-07T16:14:53Z",
            "customer_last_logged_at": "2023-06-09T11:31:48Z",
            "custom_fields": {
            },
            "device_type": "desktop",
            "remote_ip": "93.184.216.34",
            "exclude_accounts": [

            ],
            "fail_at": nil,
            "fail_error_class": nil,
            "fail_message": nil,
            "fetch_scopes": %w[accounts transactions],
            "finished": true,
            "finished_recent": true,
            "from_date": nil,
            "id": "777777777777777777",
            "interactive": false,
            "locale": "en",
            "partial": false,
            "store_credentials": true,
            "success_at": "2020-06-02T16:16:19Z",
            "to_date": nil,
            "updated_at": "2020-06-02T16:16:19Z",
            "show_consent_confirmation": false,
            "consent_id": "555555555555555555",
            "include_natures": %w[account card bonus],
            "last_stage": {
              "created_at": "2020-06-02T16:16:19Z",
              "id": "888888888888888888",
              "interactive_fields_names": nil,
              "interactive_html": nil,
              "name": "finish",
              "updated_at": "2020-06-02T16:16:19Z"
            }
          },
          "last_success_at": "2020-06-02T16:16:19Z",
          "next_refresh_possible_at": "2020-06-02T17:16:19Z",
          "provider_id": "1234",
          "provider_code": "moldindconbank_wb_md",
          "provider_name": "Moldindconbank Web Banking",
          "status": "active",
          "store_credentials": true,
          "updated_at": "2020-06-02T09:41:23Z"
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
          country_code: "XF",
          provider_code: "fakebank_simple_xf",
          consent: {
            from_date: from_date,
            scopes: %w[account_details transactions_details]
          },
          attempt: {
            from_date: from_date,
            fetch_scopes: %w[accounts transactions]
          },
          custom_fields: {
            test: true
          },
          credentials: {
            login: customer.user.email,
            password: "12345678"
          }
        }
      }
      stub_request(:post, "https://www.saltedge.com/api/v5/connections")
        .with(body: request_body.to_json)
        .to_return(status: 200, body: response_body.to_json, headers: headers)
    end

    it "returns connection data" do
      expect(subject).to eq(response_body[:data])
    end
  end

  describe "#refresh" do
    subject { described_class.new.refresh(connection_id: connection.remote_id) }

    let(:connection) { create(:connection, remote_id: "111111111111111111") }

    let(:response_body) do
      {
        "data": {
          "country_code": "MD",
          "created_at": "2020-05-07T20:09:02Z",
          "customer_id": "222222222222222222",
          "daily_refresh": false,
          "id": "111111111111111111",
          "secret": "AtQX6Q8vRyMrPjUVtW7J_O1n06qYQ25bvUJ8CIC80-8",
          "show_consent_confirmation": false,
          "last_consent_id": "555555555555555555",
          "last_attempt": {
            "api_mode": "service",
            "api_version": "5",
            "automatic_fetch": true,
            "user_present": false,
            "daily_refresh": false,
            "categorization": "personal",
            "created_at": "2020-05-07T16:14:53Z",
            "customer_last_logged_at": "2023-06-09T11:31:48Z",
            "custom_fields": {
            },
            "device_type": "desktop",
            "remote_ip": "93.184.216.34",
            "exclude_accounts": [

            ],
            "fail_at": nil,
            "fail_error_class": nil,
            "fail_message": nil,
            "fetch_scopes": %w[accounts transactions],
            "finished": true,
            "finished_recent": true,
            "from_date": nil,
            "id": "777777777777777777",
            "interactive": false,
            "locale": "en",
            "partial": false,
            "store_credentials": true,
            "success_at": "2020-06-02T16:16:19Z",
            "to_date": nil,
            "updated_at": "2020-06-02T16:16:19Z",
            "show_consent_confirmation": false,
            "consent_id": "555555555555555555",
            "include_natures": %w[account card bonus],
            "last_stage": {
              "created_at": "2020-06-02T16:16:19Z",
              "id": "888888888888888888",
              "interactive_fields_names": nil,
              "interactive_html": nil,
              "name": "finish",
              "updated_at": "2020-06-02T16:16:19Z"
            }
          },
          "last_success_at": "2020-06-02T16:16:19Z",
          "next_refresh_possible_at": "2020-06-02T17:16:19Z",
          "provider_id": "1234",
          "provider_code": "moldindconbank_wb_md",
          "provider_name": "Moldindconbank Web Banking",
          "status": "active",
          "store_credentials": true,
          "updated_at": "2020-06-02T09:41:23Z"
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
          attempt: {
            fetch_scopes: %w[accounts transactions]
          }
        }
      }
      stub_request(:put, "https://www.saltedge.com/api/v5/connections/#{connection.remote_id}/refresh")
        .with(body: request_body.to_json)
        .to_return(status: 200, body: response_body.to_json, headers: headers)
    end

    it "returns refreshed connection data" do
      expect(subject).to eq(response_body[:data])
    end
  end

  describe "#reconnect" do
    subject { described_class.new.reconnect(connection_id: connection.remote_id, user: connection.customer.user) }

    let(:connection) { create(:connection, remote_id: "111111111111111111") }

    let(:response_body) do
      {
        "data": {
          "country_code": "MD",
          "created_at": "2020-05-07T20:09:02Z",
          "customer_id": "222222222222222222",
          "daily_refresh": false,
          "id": "111111111111111111",
          "secret": "AtQX6Q8vRyMrPjUVtW7J_O1n06qYQ25bvUJ8CIC80-8",
          "show_consent_confirmation": false,
          "last_consent_id": "555555555555555555",
          "last_attempt": {
            "api_mode": "service",
            "api_version": "5",
            "automatic_fetch": true,
            "user_present": false,
            "daily_refresh": false,
            "categorization": "personal",
            "created_at": "2020-05-07T16:14:53Z",
            "customer_last_logged_at": "2023-06-09T11:31:48Z",
            "custom_fields": {
            },
            "device_type": "desktop",
            "remote_ip": "93.184.216.34",
            "exclude_accounts": [

            ],
            "fail_at": nil,
            "fail_error_class": nil,
            "fail_message": nil,
            "fetch_scopes": %w[accounts transactions],
            "finished": true,
            "finished_recent": true,
            "from_date": nil,
            "id": "777777777777777777",
            "interactive": false,
            "locale": "en",
            "partial": false,
            "store_credentials": true,
            "success_at": "2020-06-02T16:16:19Z",
            "to_date": nil,
            "updated_at": "2020-06-02T16:16:19Z",
            "show_consent_confirmation": false,
            "consent_id": "555555555555555555",
            "include_natures": %w[account card bonus],
            "last_stage": {
              "created_at": "2020-06-02T16:16:19Z",
              "id": "888888888888888888",
              "interactive_fields_names": nil,
              "interactive_html": nil,
              "name": "finish",
              "updated_at": "2020-06-02T16:16:19Z"
            }
          },
          "last_success_at": "2020-06-02T16:16:19Z",
          "next_refresh_possible_at": "2020-06-02T17:16:19Z",
          "provider_id": "1234",
          "provider_code": "moldindconbank_wb_md",
          "provider_name": "Moldindconbank Web Banking",
          "status": "active",
          "store_credentials": true,
          "updated_at": "2020-06-02T09:41:23Z"
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
          credentials: {
            login: connection.customer.user.email,
            password: "12345678"
          },
          consent: {
            scopes: %w[account_details transactions_details]
          },
          override_credentials: true
        }
      }
      stub_request(:put, "https://www.saltedge.com/api/v5/connections/#{connection.remote_id}/reconnect")
        .with(body: request_body.to_json)
        .to_return(status: 200, body: response_body.to_json, headers: headers)
    end

    it "returns reconnected connection data" do
      expect(subject).to eq(response_body[:data])
    end
  end

  describe "#destroy" do
    subject { described_class.new.destroy(connection_id: connection.remote_id) }

    let(:connection) { create(:connection, remote_id: "111111111111111111") }

    let(:response_body) do
      {
        "data": {
          "id": "111111111111111111",
          "removed": true
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
      stub_request(:delete, "https://www.saltedge.com/api/v5/connections/#{connection.remote_id}")
        .to_return(status: 200, body: response_body.to_json, headers: headers)
    end

    it "returns reconnected connection data" do
      expect(subject).to eq(response_body[:data])
    end
  end
end