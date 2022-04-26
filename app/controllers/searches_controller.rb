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
    # 選択したモデルが'User'の場合
    if model == 'user'
      case method
      when 'perfect' then
        User.where(name: content)
      when 'partial' then
        User.where('name LIKE ?','%'+content+'%')
      when 'prefix' then
        User.where('name LIKE ?', content+'%')
      when 'backward' then
        User.where('name LIKE ?', '%'+content)
      end
    # 選択したモデルが'Book'の場合
    elsif model == 'book'
      case method
      when 'perfect' then
        Book.where(title: content)
      when 'partial' then
        Book.where('title LIKE ?','%'+content+'%')
      when 'prefix' then
        Book.where('title LIKE ?', content+'%')
      when 'backward' then
        Book.where('title LIKE ?', '%'+content)
      end
    end
  end
end
