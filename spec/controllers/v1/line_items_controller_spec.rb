require "rails_helper"

describe V1::LineItemsController do
  let(:response_body) { JSON.parse(response.body) }

  describe "GET #index" do
    let(:order) { create :order }

    let!(:line_item_1) { create :line_item, name: "Macbook Pro", price: 11_999, order: order }
    let!(:line_item_2) { create :line_item, name: "iPhone 11", price: 3599, order: order }

    it "test" do
      get :index, params: { order_id: order.id }

      expect(response_body).to eq(
        [
          {
            "name" => "Macbook Pro",
            "price" => 11_999
          },
          {
            "name" => "iPhone 11",
            "price" => 3599
          }
        ]
      )
    end
  end

  describe "GET #show" do
    let!(:line_item) { create :line_item, name: "Macbook Pro", price: 11_999 }

    it "test" do
      get :show, params: { order_id: line_item.order_id, id: line_item.id }

      expect(response_body).to eq(
        "name" => "Macbook Pro",
        "price" => 11_999
      )
    end
  end

  describe "POST #create" do
    let(:order) { create :order }

    let!(:line_item) { create :line_item, name: "Macbook Pro", price: 11_999 }

    it "test" do
      post :create, params: { order_id: order.id, line_item: { name: "Macbook Pro", price: 11_999 } }

      expect(response_body).to eq(
        "name" => "Macbook Pro",
        "price" => 11_999
      )
    end

    context "when params are invalid" do
      it "test" do
        post :create, params: { order_id: order.id, line_item: { name: "", price: 11_999 } }

        expect(response_body).to eq(
          "errors" => {
            "name" => ["can't be blank"]
          }
        )
      end
    end
  end
end
