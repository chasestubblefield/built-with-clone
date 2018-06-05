require 'faraday'
require 'nokogiri'

class UrlAnalyzer
  def initialize(url)
    @url = url
  end

  def body
    @body ||= response.body.force_encoding('utf-8')
  end

  def is_html?
    response.headers['content-type'].starts_with?('text/html')
  end

  def contains_text?(text)
    body.include?(text)
  end

  def is_using_bootstrap?
    return false unless is_html?
    page.css("link[rel='stylesheet']").each do |elem|
      return true if elem[:href].include?("bootstrap.css") || elem[:href].include?("bootstrap.min.css")
    end
    return false
  end

  def is_using_google_analytics?
    return false unless is_html?
    page.css("script").each do |elem|
      return true if elem.text.include?("https://www.google-analytics.com/analytics.js")
    end
    return false
  end

  private

  def response
    @response ||= Faraday.get(@url, ssl: false)
  end

  def page
    @page ||= Nokogiri::HTML(body)
  end
end
