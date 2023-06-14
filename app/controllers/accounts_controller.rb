class AccountsController < ApplicationController
  def index
    @connection = current_user.customer.connections.find(params[:connection_id])
    @accounts = @connection.accounts
    if params[:fetch_remote]
      response = SaltEdge::AccountGateway.new.get_list(connection_id: @connection.remote_id, from_id: @accounts.last&.remote_id)
      if response.is_a?(Array)
        current_ids = @accounts.map(&:remote_id)
        response.filter { current_ids.exclude?(_1[:id]) }.each do |account|
          @accounts << Account.create(
            connection: @connection,
            remote_id: account[:id],
            name: account[:name],
            nature: account[:nature],
            balance: account[:balance],
            currency_code: account[:currency_code],
            extra: account[:extra]
          )
        end
      end
    end
  end
end