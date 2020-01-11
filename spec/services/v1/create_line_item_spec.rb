require "rails_helper"

describe V1::CreateLineItem do
  describe "#call" do
    let(:order) { create :order, value: 10 }
    let(:params) { { name: "Macbook Pro", price: 2 } }

    let(:created_line_item) { LineItem.last }

    subject(:call) { described_class.new(params: params, order: order).call }

    it "creates Line Item" do
      expect { call }.to change { order.reload.line_items.count }.from(0).to(1)

      expect(created_line_item.name).to eq "Macbook Pro"
      expect(created_line_item.price).to eq 2
    end

    it "updates Order's value" do
      expect { call }.to change { order.reload.value }.from(10).to(12)
    end

    context "when params are invalid" do
      let(:params) { { name: "", price: 2 } }

      it "does NOT create Line Item" do
        expect { call }.not_to change { order.reload.line_items.count }
      end

      it "does NOT update Order's value" do
        expect { call }.not_to change { order.reload.value }
      end
    end
  end
end
