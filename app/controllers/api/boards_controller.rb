# frozen_string_literal: true

module Api
  class BoardsController < ApplicationController
    before_action :authorized?
    before_action :board_admin?, only: [:add_user, :remove_user]
    before_action :board_user_params, only: [:add_user, :remove_user]

    def all
      render json: current_user.boards
    end

    def show
      render json: board.slice(:id, :name, :description, :background)
    end

    def create
      head :created if Board.create!(board_params.merge!(admin: current_user))
    end

    def update
      head :ok if board.update(board_params)
    end

    def add_user
      head :ok if board.add_user(User.find(params[:user_id]))
    end

    def remove_user
      head 201 if board.remove_user(User.find(params[:user_id]))
    end

    private

    def board
      @board ||= Board.find(params[:id])
    end

    def board_params
      params.permit(:name, :description, :background)
    end

    def board_admin?
      unless current_user == Board.find(params[:id]).admin
        error! 401, message: 'You are unauthorized for this action'
      end
    end

    def board_user_params
      return error!(400, message: 'No user_id param') unless params[:user_id]
    end
  end
end