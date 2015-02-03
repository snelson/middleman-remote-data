require 'faraday'
require 'faraday_middleware'
require 'faraday-http-cache'

class MiddlemanRemoteData::Fetcher

  def initialize(url)
    @url = url
    @connection = build_connection
  end

  def fetch
    @connection.get(@url).body
  end

  private

  def build_connection
    Faraday.new do |builder|
      builder.use FaradayMiddleware::FollowRedirects
      builder.use Faraday::Request::UrlEncoded
      builder.use Faraday::Adapter::NetHttp
      builder.use Faraday::HttpCache
      builder.use FaradayMiddleware::ParseXml,  :content_type => /\bxml$/
      builder.use FaradayMiddleware::ParseJson, :content_type => /\bjson$/
    end
  end
end
