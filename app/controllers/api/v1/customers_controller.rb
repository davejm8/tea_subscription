# class CustomersController < ApplicationController
#   def index
#     @subscriptions = Subscription.find(params[:customer_id])
#     render json: SubscriptionSerializer.new(@subscriptions)
#   end
# end