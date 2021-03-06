class ApplicationController < ActionController::API
  SECRET_KEY = Rails.application.secrets.secret_key_base.to_s
  
  def encode_token(payload, exp = 48.days.from_now) 
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY) 
  end

  def auth_header
    request.headers['Authorization']
  end

  def decoded_token
    if auth_header()
      token = auth_header.split(' ')[1] 
      begin
        JWT.decode(token, SECRET_KEY, true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      rescue JWT::ExpiredSignature
        nil
      end
    end
  end

  def current_user
    if decoded_token()
      user_id = decoded_token[0]['user_id'] 
      @user = User.find_by(id: user_id)
    else
      nil
    end
  end

  def logged_in?
    !!current_user
  end

  def authorized
    render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
  end

  def handle_failed(e)
    render json: ::Dto::BaseResponse.unprocessable_entity(message: e), 
      status: 422
  end

  def handle_error(e)
    render json: ::Dto::BaseResponse.bad_request(message: e),
      status: :bad_request
  end
end