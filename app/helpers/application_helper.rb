# frozen_string_literal: true

module ApplicationHelper
  def error!(*args)
    response = args.extract_options!
    render json: response, status: args.first
  end

  def render_ok(message = nil)
    render json: { message: (message || 'OK') }, status: 200
  end
end
