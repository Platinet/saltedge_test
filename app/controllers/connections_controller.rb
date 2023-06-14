class ConnectionsController < ApplicationController
  def index
    customer = current_user.customer
    @connections = customer.connections
    if params[:fetch_remote]
      response = SaltEdge::ConnectionGateway.new.get_list(customer_id: customer.remote_id, from_id: @connections.last&.remote_id)
      if response.is_a?(Array)
        current_ids = @connections.map(&:remote_id)
        response.filter { current_ids.exclude?(_1[:id]) }.each do |connection|
          @connections << Connection.create(
            customer: customer,
            remote_id: connection[:id],
            country_code: connection[:country_code],
            last_success_at: connection[:last_success_at],
            next_refresh_possible_at: connection[:next_refresh_possible_at],
            provider_id: connection[:provider_id],
            provider_code: connection[:provider_code],
            provider_name: connection[:provider_name],
            status: connection[:status],
            response: connection
          )
        end
      end
    end
  end

  def refresh
    connection = current_user.customer.connections.find(params[:id])
    if connection
      response = SaltEdge::ConnectionGateway.new.refresh(connection_id: connection.remote_id)
      if response.has_key?(:error)
        flash[:alert] = response[:message]
      else
        connection.update!(
          country_code: response[:country_code],
          last_success_at: response[:last_success_at],
          next_refresh_possible_at: response[:next_refresh_possible_at],
          provider_id: response[:provider_id],
          provider_code: response[:provider_code],
          provider_name: response[:provider_name],
          status: response[:status],
          response: response
        )
      end
    end
    redirect_to connections_path
  end

  def reconnect
    connection = current_user.customer.connections.find(params[:id])
    if connection
      response = SaltEdge::ConnectionGateway.new.reconnect(connection_id: connection.remote_id, user: current_user)
      if response.has_key?(:error)
        flash[:alert] = response[:message]
      else
        connection.update!(
          country_code: response[:country_code],
          last_success_at: response[:last_success_at],
          next_refresh_possible_at: response[:next_refresh_possible_at],
          provider_id: response[:provider_id],
          provider_code: response[:provider_code],
          provider_name: response[:provider_name],
          status: response[:status],
          response: response
        )
      end
    end
    redirect_to connections_path
  end

  def destroy
    connection = current_user.customer.connections.find(params[:id])
    if connection
      response = SaltEdge::ConnectionGateway.new.destroy(connection_id: connection.remote_id)
      if response.has_key?(:error)
        flash[:alert] = response[:message]
      else
        connection.update!(removed: true)
      end
    end
    redirect_to connections_path
  end
end