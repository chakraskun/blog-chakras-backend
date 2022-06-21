# # frozen_string_literal: true

module Api
  module V1
    module Authorization
      extend ActiveSupport::Concern
        included do
          before_action :require_login_api
        end

        def require_login_api
          return if signed_in?
          return if signed_in_api?
          render json: Dto::BaseResponse.unauthorized,
                status: :unauthorized
        end

        def signed_in_api?
          return true if @current_user.present?
          @current_user = Api::AuthorizationSolverService.authenticate(
            request.headers['Authorization']
          )
          @current_user.present?
        end
    end
  end
end
