class SearchOptionDownloads
    def apply(results)
      results.sort_by { |gem| gem['downloads'].to_i }.reverse
    end
end
