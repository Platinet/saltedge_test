class ConnectSessionsController < ApplicationController
  def create
    session = SaltEdge::ConnectSessionGateway.new.create(
      customer_id: current_user.customer.remote_id,
      from_date: Date.current.iso8601,
      period_days: 10,
      callback_url: home_index_url
    )
    if session.has_key?(:error)
      flash[:alert] = session[:error]
    else
      ConnectSession.create(
        customer: current_user.customer,
        expires_at: session[:expires_at],
        connect_url: session[:connect_url]
      )
      flash[:success] = "Session created"
    end
    redirect_to home_index_path
  end
end