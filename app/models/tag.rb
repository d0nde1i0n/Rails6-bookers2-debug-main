class Tag < ApplicationRecord
  # book_tagモデルとのアソシエーション（1：N、外部キー：tag_id）
  has_many :book_tags,dependent: :destroy, foreign_key: 'tag_id';
  # bookモデルとのアソシエーション（N：N、BookTagモデルを通して情報を取得）
  has_many :books,through: :book_tags

  # scope（名前付きスコープ）メソッド
  scope :merge_books, -> (tags){ }

  #
  def self.search_books_for(content, method)

    if method == 'perfect' #完全一致
      tags = Tag.where(name: content)
    elsif method == 'forward' #前方一致
      tags = Tag.where('name LIKE ?', content + '%')
    elsif method == 'backward' #後方一致
      tags = Tag.where('name LIKE ?', '%' + content)
    else #部分一致
      tags = Tag.where('name LIKE ?', '%' + content + '%')
    end

    # inject:繰り返しの処理に使用(使い方：配列.inject(初期値){|結果,要素| ブロック処理 })
    # tagに紐づくbooks(book_id)をresultに格納。一連の処理は配列の要素がなくなるまで繰り返す。
    return tags.inject(init = []) {|result, tag| result + tag.books}

  end
end
