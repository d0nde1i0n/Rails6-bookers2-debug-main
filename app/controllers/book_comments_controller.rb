class BookCommentsController < ApplicationController

  def create
    # viewから取得したbook_idをキーとしてBookテーブル内で一致するidのレコードを取得し、
    # 変数bookに格納する
    book = Book.find(params[:book_id])
    #ログインユーザに紐づくBookCommentsモデルのインスタンスのcommentカラムに、
    # viewから取得したコメントを格納し、インスタンスを変数commentに追加
    comment = current_user.book_comments.new(book_comment_params)
    # 変数commnentのbook_idカラムにコメント対象の投稿本のid(book.id)を格納
    comment.book_id = book.id
    # 上記3行によって、Favoriteインスタンスに必要なカラム全てに値を代入したため、
    # saveメソッド実行
    comment.save
    # リファラ（リンク元のパス）を取得し、そのパスに遷移
    redirect_to request.referer
  end

  def destroy
    # viewから取得したコメントのidをキーとして、PostCommentモデルの該当レコードを削除
    BookComment.find(params[:id]).destroy
    # リファラ（リンク元のパス）を取得し、そのパスに遷移
    redirect_to request.referer
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end