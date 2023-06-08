module SaltEdge
  class CustomerGateway < BaseGateway
    def create(identifier)
      data = {data: {identifier: identifier}}
      post("customers", data)
    end
  end
end