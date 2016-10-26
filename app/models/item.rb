class Item < ActiveRecord::Base

  CLEARANCE_PRICE_PERCENTAGE  = BigDecimal.new("0.75")

  belongs_to :style
  belongs_to :clearance_batch

  scope :sellable, -> { where(status: 'sellable') }

  def clearance!
    clearance_price = style.wholesale_price * CLEARANCE_PRICE_PERCENTAGE

    # Set minimums for clearance prices
    if style.type == 'Pants' || style.type == 'Dress'
        if clearance_price < 5
            clearance_price = 5
        end
    else
        if clearance_price < 2
            clearance_price = 2
        end
    end

    update_attributes!(status: 'clearanced', 
                       price_sold: clearance_price)
  end

end
