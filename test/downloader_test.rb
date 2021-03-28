require "test_helper"

class DownloaderTest < Minitest::Test
  def test_search_repository_uri
    assert_equal "https://api.github.com/search/repositories?q=topic:ruby+topic:rails",
      downloader(["topic:ruby", "topic:rails"]).send(:search_repository_uri).to_s

    assert_equal "https://api.github.com/search/repositories?q=topic:test&page=2&per_page=30",
      downloader(["topic:test"], { page: 2, per_page: 30 }).send(:search_repository_uri).to_s
  end

  def test_folder_path
    assert_equal "/topic:ruby", downloader(["topic:ruby"]).send(:folder_path)
    assert_equal "/topic:ruby-topic:rails", downloader(["topic:ruby", "topic:rails"]).send(:folder_path)
    assert_equal "/topic:ruby-size:<5000", downloader(["topic:ruby", "size:<5000"]).send(:folder_path)
    assert_equal "/topic:ruby-stars:10..20", downloader(["topic:ruby", "stars:10..20"]).send(:folder_path)
  end

  def test_call_github_endpoint
    downloader = downloader(["topic:ruby", "topic:rails"])
    body_response = File.open("./test/files/sample_body_response.json", "r")

    stub_request(:get, downloader.send(:search_repository_uri))
      .with(headers: { "accept" => "application/vnd.github.v3+json" })
      .to_return(status: 200, headers: { "Content-Type" => "application/json" }, body: body_response)

    res = downloader.send(:call_github_endpoint)
    image_urls = JSON.parse(res.body)["items"].map { |item| downloader.send(:avatar_url, item) }
    assert_equal ["https://secure.gravatar.com/avatar/user-240.png"], image_urls
  end

  private

  def downloader(args, options = {})
    GithubImageGrep::Downloader.new(args, options)
  end
end
