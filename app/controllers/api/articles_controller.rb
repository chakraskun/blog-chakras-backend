module Api
  class ArticlesController < ::ApplicationController
    before_action :authorized
    before_action :find_article, only: [:show]

    def index
      @articles = Article.all
      return render json: ::Dto::BaseResponse.ok(
        data: {
          articles: @articles
        }
      )
    end

    def show
      return render json: ::Dto::BaseResponse.ok(
        data: {
          article: @article
        }
      )
    end

    def create
      new_article = Article.new(article_params.merge(user_id: current_user.id))
      if new_article.save
        return render json: ::Dto::BaseResponse.ok(
          data: {
            article: new_article
          }
        )
      end
      return handle_failed(new_article.errors)
    rescue => e
      return handle_error(e)
    end

    private
      def find_article
        @article = Article.find_by(slug: params[:slug])
        if @article.nil?
          return handle_failed("article not found")
        end
      end

      def article_params
        params.require(:article).permit(:title, :outline, :content, :category_id, :is_shown, :tags, :published_at, :user_id)
      end
  end
end