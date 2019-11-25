# REFACTOR: Controller name should be something more along the lines of "dashboard" since this is no longer
# just log items.
class PopulationInquiryLogItemsController < ApplicationController
  attr_reader :log_items, :year_to_query_count
  helper_method :log_items, :year_to_query_count

  def index
    # REFACTOR: This needs pagination in the future
    @log_items = PopulationInquiryLogItem.order('created_at desc').all

    # REFACTOR: This query could get expensive over time. You would want to index
    # the year fields the join occurs on, and consider caching this query response by the most recent
    # PopulationInquiryLogItem.created_at.
    @year_to_query_count = Population
                             .left_outer_joins(:population_inquiry_log_items)
                             .group(:year_number)
                             .order(:year_number)
                             .pluck(:year_number, 'count(distinct population_inquiry_log_items.id)')
  end
end
