class BookCommentsController < ApplicationController

  def create
    # viewから取得したbook_idをキーとしてBookテーブル内で一致するidのレコードを取得し、
    # 変数bookに格納する
    @book = Book.find(params[:book_id])
    #ログインユーザに紐づくBookCommentsモデルのインスタンスのcommentカラムに、
    # viewから取得したコメントを格納し、インスタンスを変数commentに追加
    comment = current_user.book_comments.new(book_comment_params)
    # 変数commnentのbook_idカラムにコメント対象の投稿本のid(book.id)を格納
    comment.book_id = @book.id
    # 上記3行によって、Favoriteインスタンスに必要なカラム全てに値を代入したため、
    # saveメソッド実行
    comment.save
    # リファラ（リンク元のパス）を取得し、そのパスに遷移
  end

  def destroy
    # viewから取得したコメントのidをキーとして、PostCommentモデルの該当レコードを削除
    # book_idを参照する条件を追記
    BookComment.find_by(id: params[:id],book_id: params[:book_id]).destroy
    # render後に使用するインスタンス変数
    @book = Book.find(params[:book_id])
    # リファラ（リンク元のパス）を取得し、そのパスに遷移
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end