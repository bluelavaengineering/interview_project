class LogsController < ApplicationController
  def index
    @logs = Log.all
    @expact_report = Reports::Exact.call
  end
end
