class FeedsListsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user,   only: [:create, :edit, :update, :destroy, :remove_feed]

  def index
  	@user = User.find(params[:user_id])
  	@feeds_lists = @user.feeds_lists
  end

  def show
  	@user = User.find(params[:user_id])
  	@feeds_list = FeedsList.find(params[:id])
    if @feeds_list.is_private and !current_user?(@user)
      flash[:notice] = "You are trying to access a private feedslist"
      redirect_to root_path
    else
  	  @feeds = @feeds_list.feeds
      @articles = []
      if @feeds
        @feeds.each do |feed|
          feed.articles.each do |article|
            @articles << article
          end
        end
        @articles.sort! { |a, b|  a.published_at <=> b.published_at }
      end
    end
  end

  def new
  	@user = User.find(params[:user_id])
  	@feeds_list = FeedsList.new
    @feeds = Feed.all
  end

  def create
  	@feeds_list = FeedsList.new(name: params[:feeds_list][:name], is_private: params[:feeds_list][:is_private])
    @user.feeds_lists << @feeds_list
  	if @feeds_list.save
      if params[:feeds_list][:feeds][1..-1] != ""
        params[:feeds_list][:feeds][1..-1].each do |feed_id|
          if feed_id != ""
            @feed = Feed.find(feed_id)
            @feeds_list.feeds << @feed if @feed
          end
        end
      end
      feeds_url = params[:feeds_list][:feeds_url]
      if feeds_url != ""
        @feed = Feed.find_by_feed_url(feeds_url)
        if @feed
          @feeds_list.feeds << @feed
        else
          feedzirra_feed = Feedzirra::Feed.fetch_and_parse(feeds_url)
          if feedzirra_feed != 0
            @feeds_list.feeds << Feed.create(feed_url: feeds_url)
          else
            redirect_to request.referrer, notice: "Unable to retrieve feed from the URL" and return
          end
        end
      end
  		redirect_to @user
  		flash[:success] = "Successfulled created FeedsList"
  	else
      @feeds = Feed.all
  		render 'new'
  	end
  end

  def edit
    @user = User.find(params[:user_id])
  	@feeds_list = FeedsList.find(params[:id])
    @feeds = Feed.all - @feeds_list.feeds
  end

  def update
    @feeds_list = FeedsList.find(params[:id])
  	if @feeds_list.update_attributes(name: params[:feeds_list][:name])
      if params[:feeds_list][:feeds][1..-1] != ""
        params[:feeds_list][:feeds][1..-1].each do |feed_id|
          if feed_id
            @feed = Feed.find(feed_id)
            @feeds_list.feeds << @feed if @feed
          end
        end
      end
      feeds_url = params[:feeds_list][:feeds_url]
      if feeds_url != ""
        @feed = Feed.find_by_feed_url(feeds_url)
        if @feed
          @feeds_list.feeds << @feed
        else
          feedzirra_feed = Feedzirra::Feed.fetch_and_parse(feeds_url)
          if feedzirra_feed != 0
            @feeds_list.feeds << Feed.create(feed_url: feeds_url)
          else
            redirect_to request.referrer, notice: "Unable to retrieve feed from the URL" and return
          end
        end
      end
  		flash[:success] = "Successfully updated FeedsList"
  		redirect_to @user
  	else
      @feeds = Feed.all - @feeds_list.feeds
  		render 'edit'
  	end
  end

  def destroy
  	@feeds_list = FeedsList.find(params[:id])
  	@feeds_list.delete
    flash[:success] = "Successfully deleted '#{@feeds_list.name}' FeedsList"
    redirect_to @user
  end

  def remove_feed
    @feeds_list = FeedsList.find(params[:id])
    @feed = Feed.find(params[:feed_id])
    @feeds_list.feeds.delete(@feed)
    flash[:success] = "Successfully deleted #{@feed.name} from your FeedsList"
    redirect_to edit_user_feeds_list_path(@user, @feeds_list)
  end

  private

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Only signed in users can access this page. Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:user_id])
      redirect_to(root_path) unless current_user?(@user)
    end

end

