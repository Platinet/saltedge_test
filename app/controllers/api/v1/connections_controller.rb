module Api
  module V1
    class ConnectionsController < BaseController
      def create
        data = params["data"]
        create_connection(data["customer_id"], data["connection_id"])
      end

      private

      def create_connection(customer_id, connection_id)
        customer = Customer.find_by(remote_id: customer_id)
        connection = Connection.find_by(remote_id: connection_id)
        Connection.create(customer: customer, remote_id: connection_id) unless connection
      end
    end
  end
end
