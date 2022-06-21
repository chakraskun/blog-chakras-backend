module Api
  class UsersController < ::ApplicationController
    before_action :authorized
  
    def index
      @users = User.all
      return render json: ::Dto::BaseResponse.ok(
        data: {
          users: @users
        }
      )
    end
  
    def show
      return render json: ::Dto::BaseResponse.ok(
        data: {
          user: @user
        }
      )
    end
  
    def destroy
      @user.destroy
    end
  
    private
  
    def find_user
      @user = User.find_by_username!(params[:_username])
      if @user.nil?
        render json: ::Dto::BaseResponse.bad_request()
      end
    end
  
    def user_params
      params.permit(
        :avatar, :name, :username, :email, :password, :password_confirmation
      )
    end
  end
end
