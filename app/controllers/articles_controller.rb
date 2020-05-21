class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy,
                                     :versions, :version, :revert]
  before_action :set_version, only: [:version, :revert]

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def versions
    @articles = @article.versions
  end

  def version
  end

  def revert
    @reverted_article = @version.reify

    if @reverted_article.save
      redirect_to @article, notice: 'Article was successfully reverted.'
    else
      render :version
    end
  end

  def deleted
    destroyed_articles = PaperTrail::Version
      .where(item_type: 'Article', event: 'destroy')
      .order(created_at: :desc)

    latest_destroyed_articles = destroyed_articles
      .select { |v| v.reify.versions.last.event == 'destroy' }
      .map(&:reify)
      .uniq(&:id)

    @articles = latest_destroyed_articles
  end

  def restore
    latest_version = Article.new(id: params[:id]).versions.last
    # latest_version = PaperTrail::Version.where(item_type: 'Article', item_id: params[:id]).last
    if latest_version.event == 'destroy'
      @article = latest_version.reify
      if @article.save
        previous = latest_version.reify(has_many: true)
        previous.comments.each { |c| restore_association(c, latest_version.transaction_id) }
        previous.notes.each { |n| restore_association(n, latest_version.transaction_id) }
        redirect_to @article, notice: 'Article was successfully restored.'
      else
        render :deleted
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    def set_version
      @version = PaperTrail::Version.find_by(
        id: params[:version_id],
        item_id: @article
      )
    end

    def restore_association(association, transaction_id)
      association.versions.where(transaction_id: transaction_id).last.reify.save
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :body)
    end
end
