module CrimsonHexagon
  class Base < API
    include CrimsonHexagon::Monitor::Common

    def list(team = nil)
      options = {}
      options.merge(team: team) if team
      response = get("monitor/list", options)
      response.monitors
    end
  end
end
