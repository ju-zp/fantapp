class UsersController < ApplicationController

    def index
        @users = User.all
    end

    def show
        @user = User.find(session[:user_id])
    end

    def edit
        @user = User.find(session[:user_id])
    end

    def update 
        @user = User.find(params[:id])
        if @user.avatar.attached?
            @user.avatar.purge
            @user.avatar.attach(params[:avatar])
        else
            @user.avatar.attach(params[:avatar])
        end
        @user.update(user_params)
        if @user.valid?
            redirect_to '/profile'
        else
            render 'edit'
        end
    end
    
    def destroy
        User.find(session[:user_id]).destroy
        session.delete(:user_id)
        redirect_to "/"
    end

    private 

    def user_params
        params.require(:user).permit(:username, :age, :password, :password_confirmation, :avatar)
    end


end