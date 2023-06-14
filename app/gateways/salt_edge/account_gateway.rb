module SaltEdge
  class AccountGateway < BaseGateway
    def get_list(connection_id:, from_id: nil)
      get("accounts?connection_id=#{connection_id}&from_id=#{from_id}")
    end
  end
end