class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]

  # GET /articles or /articles.json
  def index
    puts "index"
    @articles = Article.all
  end

  # GET /articles/1 or /articles/1.json
  def show
    puts "show"
    p @article
    puts @article.inspect
  end

  # GET /articles/new
  def new
    puts "new article"
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
    puts "edit"
  end

  # POST /articles or /articles.json
  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = "created successfully"
      redirect_to @article, notice: "created successfully"
    else

      puts @article.errors.full_messages
      render "new", status: :unprocessable_entity
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    puts "update"
    respond_to do |format|
      puts article_params #new params
      puts @article.inspect #current params values
      if @article.update(article_params)    #updated values
        format.html { redirect_to article_url(@article), notice: "Article was successfully updated." }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url, notice: "Article was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      puts "set article"
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      puts "article params"
      params.require(:article).permit(:title, :description)
    end
end
