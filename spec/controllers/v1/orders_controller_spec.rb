require "rails_helper"

describe V1::OrdersController do
  let(:response_body) { JSON.parse(response.body) }

  describe "GET #index" do
    let!(:order_1) { create :order, customer_name: "John", value: 0 }
    let!(:order_2) { create :order, customer_name: "Chris", value: 5 }

    it "test" do
      get :index

      expect(response_body).to eq(
        [
          {
            "customer_name" => "John",
            "value" => 0.0
          },
          {
            "customer_name" => "Chris",
            "value" => 5
          }
        ]
      )
    end
  end

  describe "GET #show" do
    let(:order) { create :order, customer_name: "John", value: 0 }

    it "test" do
      get :show, params: { id: order.id }

      expect(response_body).to eq(
        "customer_name" => "John",
        "value" => 0.0
      )
    end
  end
end
