class AdminController < ApplicationController

  # GET /admin or /admin.json
  def index
    @events = Event.all
  end

end
