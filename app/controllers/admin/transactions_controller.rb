module Admin
  class TransactionsController < ApplicationController
    def index
      @transactions = Transaction.all
    end

    def show
      @transaction = Transaction.find(params[:id])
    end
  end
end