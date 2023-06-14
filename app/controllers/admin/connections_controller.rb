module Admin
  class ConnectionsController < ApplicationController
    def index
      @connections = Connection.all
    end

    def show
      @connection = Connection.preload(:accounts).find(params[:id])
    end
  end
end