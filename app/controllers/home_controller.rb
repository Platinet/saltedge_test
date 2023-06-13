class HomeController < ApplicationController
  def index
    @customer = current_user.customer
    @connect_session = @customer&.connect_sessions&.active&.last
    @connections = @customer&.connections
  end
end