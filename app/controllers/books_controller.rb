class BooksController < ApplicationController
  # ソート機能を使用するためにヘルパーメソッド追加
  # 下記ヘルパーメソッドは「books_helperm.rb」で引用されている。
  helper_method :sort_column, :sort_direction

  def show
    @book =  Book.find(params[:id])
    @book_new = Book.new
    @user = @book.user
    @book_comment = BookComment.new
  end

  def index
    # ソートするために右辺をBook.allから下記のように変更
    # sort_column:DBテーブルの中でソート対象となる列の名称を格納
    # sort_direction:「asc（昇順）」、「desc（降順）」を格納
    @books = Book.order("#{sort_column} #{sort_direction}")
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render :edit
    else
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.delete
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title,:body,:score)
  end

  def sort_direction
    # paramasに格納されている値が"asc"or"desc"であればそのままの値を、
    # それ以外の値の場合"asc"を返す
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end

  def sort_column
    # paramasに格納されている値がBookモデルのテーブルのカラムに含まれている場合は
    # そのままの値を、それ以外のばあいには"id"を返す。
    Book.column_names.include?(params[:sort]) ? params[:sort] : 'id'
  end

end
