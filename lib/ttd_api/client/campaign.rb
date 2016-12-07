module TTDApi
  class Client
    module Campaign
      def campaign_by_id(id)
        get("campaign/#{id}")
      end

      def campaign_facets
        get("campaign/query/facets")
      end

      def campaigns_by_advertiser(id,
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
        options.merge!(AdvertiserId: id,
                       PageSize: page_size,
                       PageStartIndex: page_start_index)

        post("campaign/query/advertiser", options)
      end
    end
  end
end
