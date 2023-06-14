class CustomersController < ApplicationController
  def create
    customer = SaltEdge::CustomerGateway.new.create(current_user.email)
    if customer.has_key?(:error)
      flash[:alert] = "API Error: " + customer[:error][:message]
    else
      flash[:success] = "Customer created"
      current_user.create_customer(customer.merge(remote_id: customer.delete(:id)))
    end
    redirect_to home_index_path
  end
end