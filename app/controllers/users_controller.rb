class UsersController < ApplicationController
    skip_before_action :authenticate_user_from_token!, only: [:create]

    def create
      @user = User.new user_params

      if @user.save
        render json: @user, serializer: SessionSerializer, root: nil
      else
        render json: { error: 'Error while creating user' }, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.require(:user).permit(:email, :username, :password, :password_confirmation)
    end
  end
