require "rails_helper"

describe V1::LineItemsController do
  let(:response_body) { JSON.parse(response.body) }

  describe "POST #create" do
    let(:order) { create :order }
    let(:params) { { order_id: order.id, line_item: { name: "Macbook Pro", price: 11_999 } } }
    let(:created_line_item) { LineItem.last }

    it "responds with created LineItem" do
      expect(V1::CreateLineItem).to receive(:call).with(
        params: instance_of(ActionController::Parameters),
        order: order
      ).and_call_original

      post :create, params: params

      expect(response.status).to eq(201)
      expect(response_body).to eq(
        "id" => created_line_item.id,
        "name" => "Macbook Pro",
        "price" => 11_999
      )
    end

    context "when params are invalid" do
      let(:params) { { order_id: order.id, line_item: { name: "Macbook Pro", price: -11_999 } } }

      it "responds with errors" do
        post :create, params: params

        expect(response.status).to eq(422)
        expect(response_body).to eq(
          "errors" => {
            "price" => ["must be greater than or equal to 0"]
          }
        )
      end
    end
  end
end
