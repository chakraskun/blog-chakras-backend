module Api
  class PublicController < ::ApplicationController
    def establish_connection
      return render json: ::Dto::BaseResponse.ok(
        data: {
          connection: 'ok'
        }
      )
    end
  end
end