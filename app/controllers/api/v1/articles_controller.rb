module Api
    module V1
        class ArticlesController<ApplicationController
            before_action :set_articles
            before_action :set_article, except: [:index, :create]

            def index
                render json: {status: 'SUCCESS',
                message: "Loaded articles, #{@count} articles present",
                data: @articles}, status: :ok
            end
            def show
                render json: {status: "SUCCESS", message: "Loaded article with id #{params[:id]}", data: @article}, status: :ok
            end
            def create
                @article = Article.new(article_params)

                if @article.save
                    render json: {status: "SUCCESS", message: "Article saved", data: @article}, status: :ok
                else
                    render json: {status: "ERROR", message: "Couldn't save article", data: @articles}, status: :ok
                end
            end
            def update
                if @article.update(article_params)
                    render json: {status: "SUCCESS", message: "Article updated", data: @article}, status: :ok
                else
                    render json: {status: "ERROR", message: "Couldn't update article", data: @articles}, status: :ok
                end
            end
            def destroy
                @article.destroy
                render json: {status: "SUCCESS", message: "Deleted article with id #{params[:id]}", data: @article.errors}, status: :unprocessable_entity
            end
        private
            def article_params
                params.permit(:title, :body)
            end
            def set_articles
                @articles = Article.all
                @count = Article.count
            end
            def set_article
                @article = Article.find(params[:id])
            end
        end
    end
end