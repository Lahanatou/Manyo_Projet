class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]
    before_action :not_logged_in
    before_action :only_admin
    PER = 10

    def index
    #@users = User.select(:id, :name, :email, :admin).order(created_at: :asc).page(params[:page]).per(PER)
    @users = User.all.order(created_at: :asc).page(params[:page]).per(PER)
    end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def edit

  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: 'Changed user information'
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice: "#{@user.name}Deleted user data"
    else
      redirect_to admin_users_path, notice: "Because at least one administrator is required #{@user.name}Cannot be deleted"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def only_admin
    unless current_user.admin?
      redirect_to tasks_path, notice: 'You do not have access'
      flash[:danger] = "only for admins！"
    end
  end
end
