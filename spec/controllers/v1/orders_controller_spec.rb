require "rails_helper"

describe V1::OrdersController do
  let(:response_body) { JSON.parse(response.body) }

  describe "POST #create" do
    let(:params) { { order: { customer_name: "Awesome Customer" } } }
    let(:created_order) { Order.last }

    it "responds with created Order" do
      expect { post :create, params: params }.to change { Order.count }.from(0).to(1)

      expect(response.status).to eq(201)
      expect(response_body).to eq(
        "id" => created_order.id,
        "customer_name" => "Awesome Customer",
        "value" => 0.0,
        "created_at" => created_order.created_at.iso8601,
        "ordered_line_items" => []
      )
    end

    context "when params are invalid" do
      let(:params) { { order: { customer_name: "" } } }

      it "responds with errors" do
        expect { post :create, params: params }.not_to change { Order.count }

        expect(response.status).to eq(422)
        expect(response_body).to eq(
          "errors" => {
            "customer_name" => ["can't be blank"]
          }
        )
      end
    end
  end
end
