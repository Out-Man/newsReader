class ArticlesController < ApplicationController	
    def index
      @articles = Article.find(:all, order: "published_at DESC")
      if current_user
      	@shared_articles = []
      	current_user.friends.each do |friend|
      		friend.shared_list.articles.each do |article|
      			@shared_articles << article
      		end
      	end
      	@shared_articles.sort! { |a, b|  a.published_at <=> b.published_at }
      end
    end

    def show 
    	@article = Article.find(params[:id])
      @content = "There is no content"
      if !@article.content.nil?
        @content = Article.extract_paragraphs(@article.content.sanitize)
      elsif !@article.summary.nil?
        @content = Article.extract_paragraphs(@article.summary.sanitize)
      end
      rescue ActiveRecord::RecordNotFound
        flash[:notice] = "That article could not be found"
        redirect_to root_url
    end
end
