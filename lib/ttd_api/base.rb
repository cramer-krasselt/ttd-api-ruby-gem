module TTDApi
  class Base < API
    include TTDApi::Monitor::Common

    def list(team = nil)
      options = {}
      options.merge(team: team) if team
      response = get("monitor/list", options)
      response.monitors
    end
  end
end
