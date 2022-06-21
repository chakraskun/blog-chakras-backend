# frozen_string_literal: true

module Authenticable
  def current_team
    return @current_team if @current_team

    header = request.headers['Authorization']
    return nil if header.nil?

    decode = JsonWebToken.decode(header)
    @current_team = begin
      Team.find(decoded[:team_id])
    rescue StandardError
      ActiveRecord::RecordNotFound
    end
  end
end
