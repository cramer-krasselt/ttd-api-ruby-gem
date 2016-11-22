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

      def admin_posts(id, start_date, end_date)
        response = get("monitor/facebook/adminposts",
                       id: id,
                       start: start_date,
                       end: end_date)
        response
      end

      def page_likes(id, start_date, end_date)
        response = get("monitor/facebook/pagelikes",
                       id: id,
                       start: start_date,
                       end: end_date)
        response
      end

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
