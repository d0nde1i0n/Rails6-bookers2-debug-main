class FavoritesController < ApplicationController

  def create
    # viewから取得したbook_idをキーとしてBookテーブル内で一致するidのレコードを取得し、
    # 変数bookに格納する
    book = Book.find(params[:book_id])
    # ログインユーザに紐づくFavorieモデルのインスタンス（この時user_id格納?）を生成し,
    # book_idカラムに変数bookのidを変数favoriteに格納
    favorite = current_user.favorites.new(book_id: book.id)
    # 上記2行によって、Favoriteインスタンスに必要なカラム全てに値を代入したため、
    # saveメソッド実行
    favorite.save
    # リファラ（リンク元のパス）を取得し、そのパスに遷移
    redirect_to request.referer
  end

  def destroy
    # viewから取得したbook_idをキーとしてBookテーブル内で一致するidのレコードを取得し、
    # 変数bookに格納する
    book = Book.find(params[:book_id])
    #ログインユーザに紐づくFavoriteモデルのカラムBook_idからbook.idが
    # 一致するレコードを取得し、変数favoreteに格納
    favorite = current_user.favorites.find_by(book_id: book.id)
    # 変数favoriteに格納されたレコードを削除
    favorite.destroy
    #リファラ（リンク元のパス）を取得し、そのパスに遷移
    redirect_to request.referer
  end

end
