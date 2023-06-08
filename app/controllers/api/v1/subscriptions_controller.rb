class Api::V1::SubscriptionsController < ApplicationController
  def create
    tea = Tea.find(params[:subscription][:tea_id])
    customer = Customer.find(params[:customer_id])
    subscription = customer.subscriptions.new(subscription_params)
    subscription.tea = tea

    if subscription.save
      render json: SubscriptionSerializer.new(subscription), status: :created
    else
      render json: { errors: subscription.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    subscription = Subscription.find(params[:id])
    subscription.update(subscription_params)
    if subscription.save
      render json: SubscriptionSerializer.new(subscription), status: :ok
    else 
      render json: { errors: subscription.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def subscription_params
    params.require(:subscription).permit(:title, :price, :status, :frequency)
  end
end