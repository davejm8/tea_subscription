require 'rails_helper'

RSpec.describe "Subscriptions", type: :request do
  context "POST /api/v1/customers/:customer_id/subscriptions" do
    it "creates a subscription for a customer" do
      customer = create(:customer)
      tea = create(:tea)
    
      subscription_params = { title: "Subscription Title", price: 10.00, status: "active", frequency: "monthly", tea_id: tea.id }
      headers = { "CONTENT_TYPE" => "application/json" }
      post "/api/v1/customers/#{customer.id}/subscriptions", headers: headers, params: JSON.generate({subscription: subscription_params})
      created_subscription = Subscription.last

      response_subscription = JSON.parse(response.body, symbolize_names: true)[:data]
    
      expect(response).to be_successful
      expect(created_subscription.title).to eq(subscription_params[:title])
      expect(created_subscription.price).to eq(subscription_params[:price])
      expect(created_subscription.status).to eq(subscription_params[:status])
      expect(created_subscription.frequency).to eq(subscription_params[:frequency])
      expect(created_subscription.customer_id).to eq(customer.id)
      expect(created_subscription.tea_id).to eq(tea.id)

      expect(response_subscription[:id]).to be_a(String)
      expect(response_subscription[:type]).to be_a(String)
      expect(response_subscription[:attributes]).to be_a(Hash)
      expect(response_subscription[:attributes].keys).to eq([:title, :price, :status, :frequency, :customer_id, :tea_id])
      expect(response_subscription[:attributes][:title]).to be_a(String)
      expect(response_subscription[:attributes][:price]).to be_a(Float)
      expect(response_subscription[:attributes][:status]).to be_a(String)
      expect(response_subscription[:attributes][:frequency]).to be_a(String)
    end

    it 'returns a 422 error if a required attribute is missing' do
      customer = create(:customer)
      tea = create(:tea)
    
      subscription_params = { title: "Subscription Title", price: 10.00, status: "active", tea_id: tea.id }
      headers = { "CONTENT_TYPE" => "application/json" }
      post "/api/v1/customers/#{customer.id}/subscriptions", headers: headers, params: JSON.generate({subscription: subscription_params})
      created_subscription = Subscription.last
      response_subscription = JSON.parse(response.body, symbolize_names: true)
    
      expect(response.status).to eq(422)
      expect(response_subscription[:errors]).to eq(["Frequency can't be blank"])
    end
  end

  context 'PATCH /api/v1/customers/:customer_id/subscriptions/:id' do
    it 'updates a subscription for a customer' do
      customer = create(:customer)
      tea = create(:tea)
      subscription = create(:subscription, customer: customer, tea: tea)
      subscription_params = { title: "Updated Subscription Title", price: 10.00, status: "cancelled", frequency: "monthly", tea_id: tea.id }
      headers = { "CONTENT_TYPE" => "application/json" }
      patch "/api/v1/customers/#{customer.id}/subscriptions/#{subscription.id}", headers: headers, params: JSON.generate({subscription: subscription_params})

      updated_subscription = Subscription.find(subscription.id)
      response_subscription = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(updated_subscription.title).to eq("Updated Subscription Title")
      expect(updated_subscription.price).to eq(10.00)
      expect(updated_subscription.status).to eq("cancelled")
      expect(updated_subscription.frequency).to eq("monthly")
    end

     it "returns error when update fails" do
      customer = create(:customer)
      tea = create(:tea)
      subscription = create(:subscription, customer: customer, tea: tea)

      invalid_subscription_params = { title: "", price: -1, status: "unknown", frequency: "unknown", customer_id: customer.id, tea_id: tea.id }
      headers = { "CONTENT_TYPE" => "application/json" }

      patch "/api/v1/customers/#{customer.id}/subscriptions/#{subscription.id}", headers: headers, params: JSON.generate(invalid_subscription_params)

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context 'GET /api/v1/customers/:customer_id/subscriptions' do
    it 'returns all subscriptions for a customer' do
      customer = create(:customer)
      tea1 = create(:tea)
      tea2 = create(:tea)
      tea3 = create(:tea)
      subscription1 = create(:subscription, customer: customer, tea: tea1)
      subscription2 = create(:subscription, customer: customer, tea: tea2)
      subscription3 = create(:subscription, customer: customer, tea: tea3)

      headers = { "CONTENT_TYPE" => "application/json" }
      get "/api/v1/customers/#{customer.id}/subscriptions"

      response_subscriptions = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response_subscriptions[:data].count).to eq(3)
      expect(response_subscriptions[:data][0][:id]).to eq(subscription1.id.to_s)
      expect(response_subscriptions[:data][0][:type]).to eq("subscription")
      expect(response_subscriptions[:data][0][:attributes].keys).to eq([:title, :price, :status, :frequency, :customer_id, :tea_id])
      expect(response_subscriptions[:data][0][:attributes][:title]).to eq(subscription1.title)
      expect(response_subscriptions[:data][0][:attributes][:price]).to eq(subscription1.price)
      expect(response_subscriptions[:data][0][:attributes][:status]).to eq(subscription1.status)
      expect(response_subscriptions[:data][0][:attributes][:frequency]).to eq(subscription1.frequency)
      expect(response_subscriptions[:data][0][:attributes][:customer_id]).to eq(subscription1.customer_id)
      expect(response_subscriptions[:data][0][:attributes][:tea_id]).to eq(subscription1.tea_id)
    end

    it 'returns 404 if customer does not exist' do
      headers = { "CONTENT_TYPE" => "application/json" }
      get "/api/v1/customers/123123124/subscriptions"

      expect(response.status).to eq(404)
    end
  end
end