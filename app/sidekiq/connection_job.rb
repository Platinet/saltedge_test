class ConnectionJob
  include Sidekiq::Job

  def perform
    Connection.all.each do |connection|
      response = SaltEdge::ConnectionGateway.new.refresh(connection_id: connection.remote_id)
      next if response.has_key?(:error)
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
end
