class UsersController < ApplicationController
  before_action :logged_in, only: [:new, :create]
 before_action :not_logged_in, only: [:show]
 before_action :forget_user, only: [:show]
skip_before_action :login_required, only: [:new, :create]

 def new
   @user = User.new
 end

 def create
   @user = User.new(user_params)
   if @user.save
     session[:user_id] = @user.id
     redirect_to tasks_path
   else
     render :new
   end
 end
 #
 def show
   @user = User.find(params[:id])
   if current_user.id != params[:id].to_i
     redirect_to tasks_path
   end
   @tasks = @user.tasks.ordered.kaminari(params[:page])
 end

 private
 #
 def user_params
   params.require(:user).permit(:name, :email, :password, :password_confirmation)
 end
 #
 def forget_user
   if current_user.admin == false
     if current_user.id != params[:id].to_i
       redirect_to tasks_path, notice: 'You have successfully been registered'
     end
   end
 end
end
