# Require core library
require 'middleman-core'

class MiddlemanRemoteData < ::Middleman::Extension

  def initialize(app, options_hash={}, &block)
    super

    require 'faraday'
    require 'faraday_middleware'

    app.include ClassMethods
  end

  module ClassMethods
    def data_source(name, url)
      connection = Faraday.new do |builder|
        builder.use Faraday::Request::UrlEncoded
        builder.use Faraday::Adapter::NetHttp
        builder.use FaradayMiddleware::ParseXml,  :content_type => /\bxml$/
        builder.use FaradayMiddleware::ParseJson, :content_type => /\bjson$/
      end

      data.callbacks name, Proc.new { connection.get(url).body }
    end
  end
end

MiddlemanRemoteData.register(:remote_data)
