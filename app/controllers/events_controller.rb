class EventsController < ApplicationController
  before_action :authenticate_user!, except: %i[show index]
  before_action :set_event, only: %i[show edit update destroy]

  after_action :verify_authorized, only: %i[show edit update destroy]

  def index
    @events = Event.includes(:subscribers, user: :avatar_attachment).all
  end

  def show
    if params[:pincode].present? && @event.pincode_valid?(params[:pincode])
      cookies.permanent["events_#{@event.id}_pincode"] = params[:pincode] if params[:pincode].present?
    end

    authorize @event

  rescue Pundit::NotAuthorizedError
    pincode_form

    @new_comment = @event.comments.build(params[:comment])
    @new_subscription = @event.subscriptions.build(params[:subscription])
    @new_photo = @event.photos.build(params[:photo])
  end

  def new
    @event = current_user.events.build
  end

  def edit
    authorize @event
  end

  def create
    @event = current_user.events.build(event_params)

    if @event.save
      redirect_to event_path(@event), notice: I18n.t('controllers.events.created')
    else
      render :new
    end
  end

  def update
    authorize @event

    if @event.update(event_params)
      redirect_to event_path(@event), notice: I18n.t('controllers.events.updated')
    else
      render :edit
    end
  end

  def destroy
    authorize @event

    @event.destroy

    redirect_to user_path(current_user), notice: I18n.t('controllers.events.deleted')
  end

  private

  def set_current_user_event
    @event = current_user.events.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :address, :datetime, :description, :pincode)
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def pincode_form
    flash.now[:alert] = I18n.t('controllers.events.wrong_pincode') if params[:pincode].present?
    render 'password_form'
  end
end
