module Service
  class Reports::Exact
    include Common::Service

    def call
      report_year_matches
    end

    private

      def report_year_matches
        Log.joins("INNER JOIN populations ON populations.year = logs.year").distinct.group(:year).count
      end

  end
end
