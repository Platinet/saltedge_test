module SaltEdge
  class ConnectionGateway < BaseGateway
    def get_list(customer_id:, from_id: nil)
      get("connections?customer_id=#{customer_id}&from_id=#{from_id}")
    end

    def show(connection_id:)
      get("connections/#{connection_id}")
    end

    def create(customer_id:, from_date:, user:)
      data = {
        data: {
          customer_id: customer_id,
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
            login: user.email,
            password: "12345678"
          }
        }
      }
      post("connections", data)
    end

    def refresh(connection_id:)
      data = {
        data: {
          attempt: {
            fetch_scopes: %w[accounts transactions]
          }
        }
      }
      put("connections/#{connection_id}/refresh", data)
    end

    def reconnect(connection_id:, user:)
      data = {
        data: {
          credentials: {
            login: user.email,
            password: "12345678"
          },
          consent: {
            scopes: %w[account_details transactions_details]
          },
          override_credentials: true
        }
      }
      put("connections/#{connection_id}/reconnect", data)
    end

    def destroy(connection_id:)
      delete("connections/#{connection_id}")
    end
  end
end