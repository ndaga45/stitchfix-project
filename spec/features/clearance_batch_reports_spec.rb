require "rails_helper"

describe "clearance batch reports", type: :feature do

    describe "view reports links on home page" do
        it "should display a link to view clearance batch report for each bath on the homepage" do
            clearance_batch_1 = FactoryGirl.create(:clearance_batch)
            clearance_batch_2 = FactoryGirl.create(:clearance_batch)

            visit "/"
            within('table.clearance_batches') do
                expect(page).to have_link('View Report', href: clearance_batch_report_path(clearance_batch_1.id))
                expect(page).to have_link('View Report', href: clearance_batch_report_path(clearance_batch_2.id))
            end
        end
    end

    describe "view report summarizing the clearance batch" do
        it "should display a summary of the clearance batch" do
            items = 5.times.map{ FactoryGirl.create(:item, price_sold: BigDecimal.new(5)) }
            clearance_batch = FactoryGirl.create(:clearance_batch, items: items)
            visit clearance_batch_report_path(clearance_batch.id)

            total_cost = 0
            clearance_batch.items.each do |item|
                total_cost = total_cost + item.price_sold
            end

            # Ensure that the proper data is being shown in the report
            within('table.clearance_batch_report') do
                expect(page).to have_content('Style')
                expect(page).to have_content('Style ID')
                expect(page).to have_content('Colors')
                expect(page).to have_content('Sizes')
                expect(page).to have_content('Quantity')
                expect(page).to have_content('Price')

                # Ensure that the total cost and # of items is rendered
                expect(page).to have_content('Total')
                expect(page).to have_content(clearance_batch.items.count)
                expect(page).to have_content(total_cost)
            end
        end
    end

end
