module SaltEdge
  class TransactionGateway < BaseGateway
    def get_list(connection_id:, account_id:, from_id: nil)
      get("transactions?connection_id=#{connection_id}&account_id=#{account_id}&from_id=#{from_id}")
    end
  end
end