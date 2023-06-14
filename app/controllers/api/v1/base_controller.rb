module Api
  module V1
    class BaseController < ApplicationController
      skip_before_action :authenticate_user!, raise: false
      before_action :authenticate

      private

      def authenticate
        authenticate_or_request_with_http_basic do |username, password|
          username == Rails.configuration.callback_user_name && password == Rails.configuration.callback_user_password
        end
      end
    end
  end
end
