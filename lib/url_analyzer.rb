require 'faraday'

class UrlAnalyzer
  def initialize(url)
    @url = url
  end

  def body
    @body ||= response.body
  end

  private

  def response
    @response ||= Faraday.get(@url)
  end
end
