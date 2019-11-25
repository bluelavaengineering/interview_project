# REFACTOR: Controller name should be something more along the lines of "dashboard" since this is no longer
# just log items.
class PopulationInquiryLogItemsController < ApplicationController
  attr_reader :log_items, :year_to_query_count
  helper_method :log_items, :year_to_query_count

  # NOTE: It would be more natural to implement a dashboard that replies to JSON and has a heavier
  # JS front-end (e.g. at the very least, one with built-in templating so it can do its own JSON-to-UI
  # transforms). We're taking advantage of template rendering server-side so we can keep the front-end
  # dependency light, and so we don't have to bake a lacklustre front-end data binding framework.
  def index
    # REFACTOR: This needs pagination in the future
    @log_items = PopulationInquiryLogItem.order(created_at: :desc).all

    # REFACTOR: This query could get expensive over time. You would want to index
    # the year fields the join occurs on, and consider caching this query response by the most recent
    # PopulationInquiryLogItem.created_at.
    @year_to_query_count = Population
                             .left_outer_joins(:population_inquiry_log_items)
                             .group(:year_number)
                             .order(:year_number)
                             .pluck(:year_number, Arel.sql('count(distinct population_inquiry_log_items.id)'))

    render partial: 'tables', layout: false, locals: { log_items: log_items, year_to_query_count: year_to_query_count } if request.xhr?
  end
end
