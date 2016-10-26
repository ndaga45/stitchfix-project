require 'rails_helper'

describe Item do
  describe "#perform_clearance!" do

    let(:wholesale_price) { 100 }
    let(:item) { FactoryGirl.create(:item, style: FactoryGirl.create(:style, wholesale_price: wholesale_price)) }
    before do
      item.clearance!
      item.reload
    end

    it "should mark the item status as clearanced" do
      expect(item.status).to eq("clearanced")
    end

    it "should set the price_sold as 75% of the wholesale_price" do
      expect(item.price_sold).to eq(BigDecimal.new(wholesale_price) * BigDecimal.new("0.75"))
    end
  end

  describe "clearance! minimums" do

    it "shold set the price of the clearanced item to $5 for pants/dresses" do
      wholesale_price = 6
      item = FactoryGirl.create(:item, style: FactoryGirl.create(:style, wholesale_price: wholesale_price, type: 'Pants'))
      item.clearance!
      item.reload
      expect(item.price_sold).to eq(BigDecimal.new(5))
    end

    it "should set the price of the clearanced item to the $2 minimum by default" do
      wholesale_price = 2.5
      item = FactoryGirl.create(:item, style: FactoryGirl.create(:style, wholesale_price: wholesale_price))
      item.clearance!
      item.reload
      expect(item.price_sold).to eq(BigDecimal.new(2))
    end
  end
end
