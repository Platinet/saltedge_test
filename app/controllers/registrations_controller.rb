class RegistrationsController < Devise::RegistrationsController
  def create
    super do |user|
      customer = SaltEdge::CustomerGateway.new.create(user.email)
      if customer.has_key?(:error)
        flash[:alert] = "API Error: " + customer[:error][:message]
      else
        user.create_customer(customer.merge(remote_id: customer.delete(:id)))
      end
    end
  end

  private

  def after_sign_up_path_for(resource)
    root_path
  end
end