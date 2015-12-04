class UsersController < ApplicationController

  def show
    @user = User.find_by_slug(params[:slug])
    raise ActiveRecord::RecordNotFound unless @user
  end

end
