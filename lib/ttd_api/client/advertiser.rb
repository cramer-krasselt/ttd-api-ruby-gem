module TTDApi
  class Client
    module Advertiser
      def advertiser_by_id(id)
        get("advertiser/#{id}")
      end

      def advertiser_facets
        get("advertiser/query/facets")
      end

      def advertisers_by_partner(id,
                                 page_start_index = 0,
                                 page_size = nil,
                                 search_terms = nil,
                                 sort_fields = nil,
                                 availabilities = nil)
        options = {}
        # Optionals
        options.merge!(SearchTerms: search_terms) if search_terms
        options.merge!(SortFields: sort_fields) if sort_fields
        options.merge!(Availabilities: availabilities) if availabilities
        # Required
        options.merge!(PartnerId: id,
                       PageSize: page_size,
                       PageStartIndex: page_start_index)

        post("advertiser/query/partner", options)
      end
    end
  end
end
