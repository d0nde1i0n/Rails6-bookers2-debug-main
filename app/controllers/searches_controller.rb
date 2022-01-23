class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @model = params["model"]
    @content = params["content"]
    @method = params["method"]
    @records = search_for(@model,@content,@method)
  end

  private

  def search_for(model,content,method)
    # 選択したモデルが'Uer'の場合
    if model == 'user'
      if method == 'perfect'
        User.where(name: content)
      else
        User.where('name LIKE ?','%'+content+'%')
      end
    # 選択したモデルが'Book'の場合
    elsif model == 'book'
      if method == 'perfect'
        Book.where(title: content)
      else
         Book.where('title LIKE ?','%'+content+'%')
      end
    end
  end

end
