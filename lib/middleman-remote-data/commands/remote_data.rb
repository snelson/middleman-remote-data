require 'middleman-core/cli'

module Middleman
  module Cli
    class RemoteData < Thor
      include Thor::Actions

      check_unknown_options!

      namespace :remote_data

      def self.exit_on_failure?
        true
      end

      desc "remote_data [options]", "Run this amazing command"
      method_option "download",
        type: :boolean,
        aliases: "-d",
        desc: "download all the remote data to local data"
      method_option "remove",
        type: :boolean,
        aliases: "-r",
        desc: "remove all the downloaded remote data from local data"
      def remote_data
        if options[:download]
          download_data
        elsif options[:remove]
          remove_data
        end
      end

      private

      def download_data
        shared_instance = ::Middleman::Application.server.inst
        shared_instance.data_sources.each do |name, data_source|
          data_source.download
          puts "Downloaded #{data_source.file_name} to data directory."
        end
      end

      def remove_data
        shared_instance = ::Middleman::Application.server.inst
        shared_instance.data_sources.each do |name, data_source|
          if data_source.downloaded?
            data_source.remove_download
            puts "Removed #{data_source.file_name} from data directory."
          end
        end
      end
    end
  end
end
