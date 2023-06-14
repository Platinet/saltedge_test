module SaltEdge
  class ConnectSessionGateway < BaseGateway
    def create(customer_id:, from_date:, period_days:, callback_url:)
      data = {
        data: {
          customer_id: customer_id,
          consent: {
            from_date: from_date,
            period_days: period_days,
            scopes: %w[account_details transactions_details]
          },
          attempt: {
            return_to: callback_url
          }
        }
      }
      post("connect_sessions/create", data)
    end
  end
end