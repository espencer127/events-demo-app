class AdminController < ApplicationController

  # GET /admin or /admin.json
  def index
    @events = Event.all.order(:start_time)
  end

end
