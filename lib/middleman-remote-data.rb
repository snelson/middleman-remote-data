require 'middleman-core'
require 'middleman-remote-data/commands/remote_data'

class MiddlemanRemoteData < ::Middleman::Extension

  def initialize(app, options_hash={}, &block)
    super

    require 'middleman-remote-data/data_source'

    app.include ClassMethods
  end

  module ClassMethods
    def data_source(name, url)
      data_sources[name] = data_source = MiddlemanRemoteData::DataSource.new(self, name, url)
      data.callbacks name, Proc.new { data_source.data }
    end

    def data_sources
      @data_sources ||= {}
    end
  end

end

MiddlemanRemoteData.register(:remote_data)
