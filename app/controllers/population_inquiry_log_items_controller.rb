class PopulationInquiryLogItemsController < ApplicationController
  attr_reader :log_items
  helper_method :log_items

  def index
    # REFACTOR: This needs pagination in the future
    @log_items = PopulationInquiryLogItem.order('created_at desc').all
  end
end
