class CommentsController < BaseController

  def create
    @comment = Comment.new comment_params

    respond_to do |format|
      if @comment.save
        format.js
      else
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:name, :email, :parent_id, :content, :article_id)
    end
end
