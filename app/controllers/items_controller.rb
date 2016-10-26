class ItemsController < ApplicationController
    def index
        @group_by = params[:group_by]
        items = Item.all

        if (@group_by == 'status')
            @groups = items.group_by { |item| item.status }
        elsif (@group_by == 'batch')
            @groups = items.group_by { |item| item.clearance_batch_id }
        end

        @group_labels = @groups.keys.compact.sort.map { |label| label.to_s }
    end
end
