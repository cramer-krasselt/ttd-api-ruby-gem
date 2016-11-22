require File.expand_path('../common', __FILE__)

module CrimsonHexagon
  module Monitor
    class Facebook < API
      include CrimsonHexagon::Monitor::Common

      def list(team = nil)
        options = {}
        options.merge(team: team) if team
        response = get("monitor/list", options)
        response.monitors.select do |item|
          item.type == "SOCIAL" &&
            item.sources.any? { |src| src =~ /facebook/i }
        end
      end


      # Returns a list of comments for a given media item ID
      #
      # @overload media_comments(id)
      #   @param id [Integer] An Instagram media item ID
      #   @return [Hashie::Mash] The requested comments.
      #   @example Returns a list of comments for the media item of ID 1234
      #     Instagram.media_comments(777)
      # @format :json
      # @authenticated true
      #
      #   If getting this data of a protected user, you must be authenticated (and be allowed to see that user).
      # @rate_limited true
      # @see http://instagram.com/developer/endpoints/comments/#get_media_comments
      def admin_posts(id, start_date, end_date)
        response = get("monitor/facebook/adminposts",
                       id: id,
                       start: start_date,
                       end: end_date)
        response
      end

      # Creates a comment for a given media item ID
      #
      # @overload create_media_comment(id, text)
      #   @param id [Integer] An Instagram media item ID
      #   @param text [String] The text of your comment
      #   @return [Hashie::Mash] The comment created.
      #   @example Creates a new comment on media item with ID 777
      #     Instagram.create_media_comment(777, "Oh noes!")
      # @format :json
      # @authenticated true
      #
      #   If getting this data of a protected user, you must be authenticated (and be allowed to see that user).
      # @rate_limited true
      # @see http://instagram.com/developer/endpoints/comments/#post_media_comments
      def page_likes(id, start_date, end_date)
        response = get("monitor/facebook/pagelikes",
                       id: id,
                       start: start_date,
                       end: end_date)
        response
      end

      # Deletes a comment for a given media item ID
      #
      # @overload delete_media_comment(media_id, comment_id)
      #   @param media_id [Integer] An Instagram media item ID.
      #   @param comment_id [Integer] Your comment ID of the comment you wish to delete.
      #   @return [nil]
      #   @example Delete the comment with ID of 1234, on the media item with ID of 777
      #     Instagram.delete_media_comment(777, 1234)
      # @format :json
      # @authenticated true
      #
      #   In order to remove a comment, you must be the owner of the comment, the media item, or both.
      # @rate_limited true
      # @see http://instagram.com/developer/endpoints/comments/#delete_media_comments
      def total_activity(id, start_date, end_date)
        response = get("monitor/facebook/totalactivity",
                       id: id,
                       start: start_date,
                       end: end_date)
        response
      end
    end
  end
end
