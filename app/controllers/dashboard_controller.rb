class DashboardController < ApplicationController
  skip_before_action :authenticate_user!
  layout false

  def index; end
end
