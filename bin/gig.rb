#!/usr/bin/env ruby

require "bundler/setup"
require "optparse"
require "github_image_grep/downloader"
require "github_image_grep/version"

options = {}.tap do |options|
  OptionParser.new do |option|
    option.on("--v", "--version", "Print the version") do |_value|
      puts GithubImageGrep::VERSION
      exit
    end

    option.on("-v", "--verbose", "Get verbose logging") do |_value|
      options[:verbose] = true
    end

    option.on("-fFOLDER", "--images-folder=FOLDER", "Set custom folder for the images") do |value|
      options[:images_folder] = value
    end

    option.on("-oFILE", "--output-file=FILE", "Set custom output file instead of STDOUT for logging") do |value|
      options[:output_file] = value
    end

    option.on("--github-access-token=TOKEN", "Set your GitHub access token to perform an authorized call") do |value|
      options[:github_authentication] = value
    end

    option.on("--per-page=PER_PAGE", "Define pagination size") do |value|
      options[:per_page] = value
    end

    option.on("--page=PAGE", "Request specific page") do |value|
      options[:page] = value
    end
  end.parse!
end

GithubImageGrep::Downloader.new(ARGV, options).perform
