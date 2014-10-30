class AdminController < ApplicationController
  before_filter :authorized?

  private

  def authorized?
    authenticate_user! if (current_user && !current_user.admin?) || !current_user
  end
end