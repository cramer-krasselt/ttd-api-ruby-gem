require File.expand_path('../common', __FILE__)

module CrimsonHexagon
  module Monitor
    class Twitter < API
      include CrimsonHexagon::Monitor::Common

      def list(team = nil)
        options = {}
        options.merge!(team: team) if team
        response = get("monitor/list", options)
        response.monitors.select do |item|
          item.type == "SOCIAL" &&
            item.sources.any? { |src| src =~ /twitter/i }
        end
      end

      def authors(id, start_date, end_date)
        response = get("monitor/authors",
                       id: id,
                       start: start_date,
                       end: end_date)
        response
      end

      def twitter_metrics(id, start_date, end_date)
        response = get("monitor/twittermetrics",
                       id: id,
                       start: start_date,
                       end: end_date)
        response
      end

      def followers(id, start_date, end_date)
        response = get("monitor/twittersocial/followers",
                       id: id,
                       start: start_date,
                       end: end_date)
        response
      end

      def sent_posts(id, start_date, end_date)
        response = get("monitor/twittersocial/sentposts",
                       id: id,
                       start: start_date,
                       end: end_date)
        response
      end

      def total_engagement(id, start_date, end_date)
        response = get("monitor/twittersocial/totalengagement",
                       id: id,
                       start: start_date,
                       end: end_date)
        response
      end
    end
  end
end
