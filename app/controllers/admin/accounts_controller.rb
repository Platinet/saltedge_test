module Admin
  class AccountsController < ApplicationController
    def index
      @accounts = Account.all
    end

    def show
      @account = Account.preload(:transactions).find(params[:id])
    end
  end
end