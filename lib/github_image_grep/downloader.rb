require "net/http"
require "json"
require "open-uri"
require "fileutils"
require "logger"

module GithubImageGrep
  class Downloader
    GITHUB_API_HOST = "https://api.github.com".freeze

    attr_accessor :args, :options

    def initialize(args, options)
      @args = args
      @options = options
    end

    def perform
      log("Parameters - args: #{args}, options: #{options}", verbose_only: true)

      res = call_github_endpoint
      case res
      when Net::HTTPForbidden
        log("Forbidden: you may have exceeded GitHub API rate limit. Try again later.", level: :error)
      when Net::HTTPSuccess
        log("Repositories' info fetched", verbose_only: true)

        # Create the directory if it doesn't exist yet
        FileUtils.mkdir_p(folder_path)

        body = JSON.parse(res.body)
        body["items"].each do |item|
          avatar_url = item.dig("owner", "avatar_url")
          if avatar_url
            log("Fetching #{avatar_url}", verbose_only: true)
            open(avatar_url) do |remote_file|
              File.open("#{folder_path}/#{file_name(avatar_url)}.png", "wb") do |local_file|
                local_file.write(remote_file.read)
              end
            end
          end
        end
      else
        message = JSON.parse(res.body)["message"] rescue nil
        log({ code: res.code, message: message, body: res.body }, level: :error)
      end
    end

    private

    def logger
      @_logger ||= Logger.new(options[:output_file] || STDOUT)
    end

    def log(message, verbose_only: false, level: :info)
      if !verbose_only || options[:verbose]
        logger.send(level, message)
      end
    end

    def search_repository_uri(args)
      URI("#{GITHUB_API_HOST}/search/repositories?q=#{args.join("+")}")
    end

    def call_github_endpoint
      log("Calling GitHub API")
      uri = search_repository_uri(args)
      log(uri.to_s, verbose_only: true)
      request = Net::HTTP::Get.new(uri, {
        "accept" => "application/vnd.github.v3+json"
      })

      Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(request)
      end
    end

    def folder_path
      "#{options[:images_folder]}/" + args.join("-")
    end

    def file_name(avatar_url)
      avatar_url.split("/").last.split("?").first
    end
  end
end
