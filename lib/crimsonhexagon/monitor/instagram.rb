require File.expand_path('../common', __FILE__)

module CrimsonHexagon
  module Monitor
    class Instagram < API
      include CrimsonHexagon::Monitor::Common

      def list(team = nil)
        options = {}
        options.merge!(team: team) if team
        response = get("monitor/list", options)
        response.monitors.select do |item|
          item.type == "SOCIAL" &&
            item.sources.any? { |src| src =~ /instagram/i }
        end
      end

      def followers(id, start_date, end_date)
        response = get("monitor/instagram/followers",
                       id: id,
                       start: start_date,
                       end: end_date)
        response
      end

      def sent_media(id, start_date, end_date)
        response = get("monitor/instagram/sentmedia",
                       id: id,
                       start: start_date,
                       end: end_date)
        response
      end

      def total_activity(id, start_date, end_date)
        response = get("monitor/instagram/totalactivity",
                       id: id,
                       start: start_date,
                       end: end_date)
        response
      end
    end
  end
end
