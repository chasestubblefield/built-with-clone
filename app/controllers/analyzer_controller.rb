require 'url_analyzer'

class AnalyzerController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create_or_show
    if params[:url]
      @analyzer = UrlAnalyzer.new(params[:url])
      render json: {body: @analyzer.body}
    else
      render json: {error: "Please provide a url!"}, status: :bad_request
    end
  end
end
