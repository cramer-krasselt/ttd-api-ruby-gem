module TTDApi
  class Client
    module AdGroup
      def ad_group_by_id(id)
        get("adgroup/#{id}")
      end

      def ad_group_facets
        get("adgroup/query/facets")
      end

      def ad_groups_by_campaign(id,
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
        options.merge!(CampaignId: id,
                       PageSize: page_size,
                       PageStartIndex: page_start_index)

        post("adgroup/query/campaign", options)
      end

      def ad_groups_by_advertiser(id,
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

        post("adgroup/query/advertiser", options)
      end

    end
  end
end
