class CommentsController < ApplicationController
  def create
    @prototype = Prototype.find(params[:prototype_id])
    @comment = @prototype.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @prototype
    else
      # 空欄でコメントを送信した場合にエラーを起こすのではなく詳細ページに遷移するようにしたい
      @comments = @prototype.comments.includes(:user)
      render "prototypes/show"
    end
  end

  def show
    @prototype = Prototype.find(params[:prototype_id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end
