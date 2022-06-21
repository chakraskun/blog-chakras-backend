module Api
  class CategoriesController < ::ApplicationController
    before_action :authorized
    before_action :find_category, only: [:show]

    def index
      @categories = Category.all
      return render json: ::Dto::BaseResponse.ok(
        data: {
          categories: @categories
        }
      )
    end

    def show
      return render json: ::Dto::BaseResponse.ok(
        data: {
          category: @category
        }
      )
    end

    def create
      new_category = Category.new(category_params)
      if new_category.save
        return render json: ::Dto::BaseResponse.ok(
          data: {
            category: new_category
          }
        )
      end

      return handle_failed(new_category.errors)
    rescue => e
      return handle_error(e)
    end
    

    private
      def find_category
        @category = Category.find_by(name: params[:name])
        if @category.nil?
          return handle_failed("category not found")
        end
      end

      def category_params
        params.require(:category).permit(:name)
      end
  end
end