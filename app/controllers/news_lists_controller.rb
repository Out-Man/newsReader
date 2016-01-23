class NewsListsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user,   only: [:create, :edit, :update, :destroy, :add_article, :remove_article]

  def index
  	@user = User.find(params[:user_id])
  	@news_lists = @user.news_lists
  end

  def show
  	@user = User.find(params[:user_id])
  	@news_list = NewsList.find(params[:id])
	  @articles = @news_list.articles
    if @articles
      @articles.sort! { |a, b|  a.published_at <=> b.published_at }
    end
  end

  def new
  	@user = User.find(params[:user_id])
  	@news_list = NewsList.new
  end

  def create
  	@news_list = NewsList.new(name: params[:news_list][:name])
    @user.news_lists << @news_list
  	if @news_list.save
  		redirect_to user_news_list_path(@user, @news_list)
  		flash[:success] = "Successfulled created NewsList"
  	else
      @news_lists = @user.news_lists
  		render 'index'
  	end
  end

  def edit
    @user = User.find(params[:user_id])
  	@news_list = NewsList.find(params[:id])
  end

  def update
    @news_list = NewsList.find(params[:id])
  	if @news_list.update_attributes(name: params[:news_list][:name])
  		flash[:success] = "Successfully updated NewsList"
  		redirect_to user_news_list_path(@user, @news_list)
  	else
      @news_lists = @user.news_lists
  		render 'edit'
  	end
  end

  def destroy
  	@news_list = NewsList.find(params[:id])
  	@news_list.delete
    flash[:success] = "Successfully deleted '#{@news_list.name}' NewsList"
    @news_lists = @user.news_lists
    redirect_to user_path(@user)
  end

  def add_article
    @user = User.find(params[:user_id])
    @article = Article.find(params[:article_id])
    @news_list = NewsList.find(params[:id])
    if @article
      @news_list.articles << @article
      flash[:success] = "Article added to NewsList."
      redirect_to request.referrer
    else
      @articles = @news_list.articles
      if @articles
        @articles.sort! { |a, b|  a.published_at <=> b.published_at }
      end
      render 'show'
    end
  end

  def remove_article
    @user = User.find(params[:user_id])
    @article = Article.find(params[:article_id])
    @news_list = NewsList.find(params[:id])
    if @article
      @news_list.articles.delete(@article)
      flash[:success] = "Article removed from NewsList."
      redirect_to request.referrer
    else
      @articles = @news_list.articles
      if @articles
        @articles.sort! { |a, b|  a.published_at <=> b.published_at }
      end
      render 'show'
    end
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

