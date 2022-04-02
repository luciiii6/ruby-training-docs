class SearchOptionLicense

    def initialize(license)
      @license = license
    end
    
    def apply(results)
      results.select { |gem| gem['licenses'].include?(@license) }
    end
end
