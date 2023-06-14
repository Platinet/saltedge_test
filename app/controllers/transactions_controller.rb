class TransactionsController < ApplicationController
  def index
    connection = current_user.customer.connections.find(params[:connection_id])
    @account = connection.accounts.find(params[:account_id])
    @transactions = @account.transactions
    if params[:fetch_remote]
      response = SaltEdge::TransactionGateway.new
        .get_list(connection_id: connection.remote_id, account_id: @account.remote_id, from_id: @transactions.last&.remote_id)
      if response.is_a?(Array)
        current_ids = @transactions.map(&:remote_id)
        response.filter { current_ids.exclude?(_1[:id]) }.each do |transaction|
          @transactions << Transaction.create(
            account: @account,
            remote_id: transaction[:id],
            duplicated: transaction[:duplicated],
            mode: transaction[:mode],
            status: transaction[:status],
            made_on: transaction[:made_on],
            currency_code: transaction[:currency_code],
            description: transaction[:description],
            category: transaction[:category]
          )
        end
      end
    end
  end
end