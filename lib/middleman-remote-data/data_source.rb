require 'middleman-remote-data/fetcher'

class MiddlemanRemoteData::DataSource
  attr_reader :app, :name, :url

  def initialize(app, name, url)
    @app, @name, @url = app, name, url
    @fetcher = MiddlemanRemoteData::Fetcher.new(url)
  end

  def data
    @fetcher.fetch
  end

  def download
    File.open(file_path, 'w') { |file| file.write(data.to_json) }
  end

  def remove_download
    File.delete(file_path) if downloaded?
  end

  def downloaded?
    File.exists?(file_path)
  end

  def file_name
    "#{name}.json"
  end

  def file_path
    root = Pathname(app.root)
    data_path = root + app.data_dir
    data_path + file_name
  end

end
