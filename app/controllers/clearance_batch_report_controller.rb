class ClearanceBatchReportController < ApplicationController
    def show
        @id = params[:id]
        @clearanced_styles = {}
        @total = 0

        @clearance_batch = ClearanceBatch.find(@id);

        # Index items by style ID and and size to calculate count of each object
        @clearance_batch.items.each do |item|
            style = Style.find(item.style_id)

            if @clearanced_styles[style.id] && @clearanced_styles[style.id][item.size]
                @clearanced_styles[style.id][item.size][:count] = @clearanced_styles[style.id][item.size][:count] + 1
            elsif @clearanced_styles[style.id]
                @clearanced_styles[style.id][item.size] = {
                    count: 1,
                    color: item.color,
                    price: item.price_sold,
                    name: style.name
                }
            else
                @clearanced_styles[style.id] = {
                    item.size => {
                        count: 1,
                        color: item.color,
                        price: item.price_sold,
                        name: style.name
                    }
                }
            end   

            @total = @total + item.price_sold  
        end
    end
end