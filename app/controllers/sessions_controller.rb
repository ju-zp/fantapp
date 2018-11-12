class SessionsController < ApplicationController

    def new
    end

    def create
        @user = User.find_by(username: params[:username].downcase)
        return head(:forbidden) unless @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect_to @user
    end

    def destroy
        byebug
        session.delete!(:user_id)
        redirect_to '/'
    end

end