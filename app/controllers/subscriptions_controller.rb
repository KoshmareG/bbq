class SubscriptionsController < ApplicationController
  before_action :set_event, only: %i[create destroy]
  before_action :set_subscription, only: %i[destroy]

  def create
    @subscription = Subscription.new(subscription_params)

    if @subscription.save
      redirect_to @subscription, notice: "Subscription was successfully created."
    else
      render :new
    end
  end

  def destroy
    @subscription.destroy

    redirect_to subscriptions_url, notice: "Subscription was successfully destroyed."
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_subscription
    @subscription = @event.subscription.find(params[:id])
  end

  def subscription_params
    params.fetch(:subscription, {}).permit(:user_name, :user_email)
  end
end
