# frozen_string_literal: true

class UrlsController < ApplicationController
  after_action :update_url, only: :visit
  def index
    @url = Url.new
    @urls = Url.last(10)
  end

  def create
    @url = Url.new(url_params)
    if @url.save
      redirect_to url_path(@url), status: :created
    else
      render :index, status: :unprocessable_entity
    end
  end

  def show
    @url = Url.find_by(short_url: params[:url])
    if @url
      last_clicks = @url.clicks.where.not(created_at: DateTime.now.beginning_of_day..DateTime.now.end_of_day)
      @daily_clicks = last_clicks.group("DATE_TRUNC('day',created_at)").limit(10).count.to_a.map{|e| [(Date.current - e[0].to_date).to_i.to_s, e[1]]}
      @browsers_clicks = @url.clicks.where(created_at: 10.days.ago..DateTime::Infinity.new).group_by(&:browser).to_a.map{ |e| [e[0], e[1].size] }
      @platform_clicks = @url.clicks.where(created_at: 10.days.ago..DateTime::Infinity.new).group_by(&:platform).to_a.map{ |e| [e[0], e[1].size] }
    else
      not_found
    end
  end

  def visit
    @url = Url.find_by(short_url: params[:url])
    if @url
      redirect_to @url.original_url
    else
      not_found
    end

  end

  private

  def url_params
    params.require(:url).permit(:original_url)
  end

  def update_url
    if @url
      @url.update(clicks_count: @url.clicks_count + 1)
      @url.clicks.create(browser: browser.name, platform: browser.platform.name)
    end
  end
end
