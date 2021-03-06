gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/article_feed/feed'

class FeedTest < Minitest::Test
  class FakeDataSource
    def fetch(path)
      if path == "articles"
        JSON.parse( File.read('./test/fixtures/articles.json'))
      else
        JSON.parse( File.read('./test/fixtures/article.json'))
      end
    end
  end

  class FakeArticleStore < ArticleFeed::ArticleStore
    def data_source
      FakeDataSource.new
    end
  end

  attr_reader :feed

  def setup
    @feed = ArticleFeed::Feed.new(FakeArticleStore)
  end

  def test_first_article_is_first_in_the_data_store
    expected = "Qui Ipsa Maiores Iusto Eligendi Aut 0"
    assert_equal expected, feed.first_article.title
  end

  def test_it_finds_the_first_article
    expected_title = "Qui Ipsa Maiores Iusto Eligendi Aut 0"
    assert_equal expected_title, feed.first_article.title
  end

  def test_it_finds_the_first_article_word_count
    first_article = feed.first_article
    assert_equal 26, first_article.word_count
  end
end
