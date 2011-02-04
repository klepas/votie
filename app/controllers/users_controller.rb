class UsersController < ApplicationController
  before_filter :deny_access, :only => :index
  before_filter :require_no_user, :only => :new
  before_filter :require_user, :only => [:edit, :update]
  before_filter :edit_self_only, :only => [:edit, :update]

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      flash[:notice] = "You've successfully signed up!"
      redirect_back_or_default(root_path)
    else
      render :action => "new"
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      redirect_to root_url, :notice => 'Your preferences were successfully updated.'
    else
      render :action => "edit"
    end
  end

  private
  def edit_self_only
    if !current_user or params[:id].to_i != current_user.id
      redirect_to root_url, :notice => 'You may not modify that user.'
    end
  end
end
