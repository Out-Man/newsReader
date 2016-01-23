class SharedListsController < ApplicationController
	before_filter :signed_in_user

	def show
		@user = User.find(params[:user_id])
		@articles = @user.favorite_list.articles
	end

	def add_article
		@user = User.find(params[:user_id])
		@article = Article.find(params[:id])
		if @article
			@user.shared_list.articles << @article
			flash[:success] = "Article shared to friends."
			redirect_to request.referrer
		else
			render 'show'
		end
	end

	def remove_article
		@user = User.find(params[:user_id])
		@article = Article.find(params[:id])
		if @article
			@user.shared_list.articles.delete(@article)
			flash[:success] = "Article removed from the shared list."
			redirect_to request.referrer
		else
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
end
