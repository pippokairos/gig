require "test_helper"

class DownloaderTest < Minitest::Test
  def test_search_repository_uri
    assert_equal "https://api.github.com/search/repositories?q=topic:ruby+topic:rails",
      downloader(["topic:ruby", "topic:rails"]).send(:search_repository_uri).to_s
  end

  def test_folder_path
    assert_equal "/topic:ruby", downloader(["topic:ruby"]).send(:folder_path)
    assert_equal "/topic:ruby-topic:rails", downloader(["topic:ruby", "topic:rails"]).send(:folder_path)
    assert_equal "/topic:ruby-size:<5000", downloader(["topic:ruby", "size:<5000"]).send(:folder_path)
    assert_equal "/topic:ruby-stars:10..20", downloader(["topic:ruby", "stars:10..20"]).send(:folder_path)
  end

  private

  def downloader(args, options = {})
    GithubImageGrep::Downloader.new(args, options)
  end
end
