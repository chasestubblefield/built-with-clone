require 'url_analyzer'

class AnalyzerController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create_or_show
    if params[:url]
      @analyzer = UrlAnalyzer.new(params[:url])
      response = {
        body: @analyzer.body,
        is_html: @analyzer.is_html?,
        is_using_bootstrap: @analyzer.is_using_bootstrap?,
        is_using_google_analytics: @analyzer.is_using_google_analytics?,
      }
      if params[:search]
        response[:contains_search_term] = @analyzer.contains_text?(params[:search])
      end
      render json: response
    else
      render json: {error: "Please provide a url!"}, status: :bad_request
    end
  end
end
