module Beagle

  class Metrics

    def initialize(metrics=[])
      @metrics = metrics
      @spec_types = @metrics.keys.sort
    end

    def get_binding
      binding
    end

  end

end