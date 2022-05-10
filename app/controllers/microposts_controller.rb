class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %w[create destroy]

  def create; end

  def destroy; end
end
