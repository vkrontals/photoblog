class UsersController < ApplicationController

  def show
    @user = User.find_by_slug(params[:slug])
  end

end
