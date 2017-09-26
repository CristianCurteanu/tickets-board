# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ApplicationHelper
  include Api::SessionHelper
  include Api::UsersHelper

  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordInvalid, with: :invalid_record_exception

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_exception

  rescue_from NoMethodError, with: :display_nil_exception

  rescue_from JWT::DecodeError, with: :token_wrong_format

  if Rails.env.production?
    rescue_from Exception, with: :display_nil_exception
  end

  private

  def display_nil_exception(ex)
    error! 500, message: (Rails.env.production? ? 'Internal Server Error' : ex.message)
  end

  def invalid_record_exception(ex)
    error! 400, message: ex.record.errors
  end

  def record_not_found_exception(ex)
    error! 404, message: ex.message
  end

  def token_wrong_format(_ex)
    error! 400, message: 'Check your JWT data'
  end
end
