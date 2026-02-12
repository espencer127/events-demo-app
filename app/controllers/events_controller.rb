class EventsController < ApplicationController
  before_action :set_event, only: %i[ show edit update destroy toggle_published ]

  # GET /events or /events.json
  def index
    @events = Event.where(published: true).where("end_time >= ?", Time.current).order(:start_time)
  end

  # GET /admin/new
  def new
    @event = Event.new
  end

  # POST /admin or /admin.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: "Event was successfully created." }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/1 or /admin/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: "Event was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/1 or /admin/1.json
  def destroy
    @event.destroy!

    respond_to do |format|
      format.html { redirect_to admin_index_path, notice: "Event was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  def toggle_published
    @event.toggle(:published).save

    respond_to do |format|
      format.html { redirect_to admin_index_path, notice: "Event was successfully updated.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def event_params
    params.require(:event).permit(:title, :description, :start_time, :end_time, :location, :published)
  end



end
