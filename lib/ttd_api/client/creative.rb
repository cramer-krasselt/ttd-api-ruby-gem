module TTDApi
  class Client
    module Creative
      def creative_by_id(id)
        get("creative/#{id}")
      end

      def creative_facets
        get("creative/query/facets")
      end

      def creatives_by_advertiser(id,
                                 page_start_index = 0,
                                 page_size = nil,
                                 search_terms = nil,
                                 sort_fields = nil,
                                 creative_types = nil,
                                 creative_audit_status_filter = nil,
                                 availabilities = nil)
        options = {}
        # Optionals
        options.merge!(SearchTerms: search_terms) if search_terms
        options.merge!(SortFields: sort_fields) if sort_fields
        options.merge!(CreativeTypes: creative_types) if creative_types
        options.merge!(CreativeAuditStatusFilter: creative_audit_status_filter) if creative_audit_status_filter
        options.merge!(Availabilities: availabilities) if availabilities
        # Required
        options.merge!(AdvertiserId: id,
                       PageSize: page_size,
                       PageStartIndex: page_start_index)

        post("creative/query/advertiser", options)
      end
    end
  end
end
