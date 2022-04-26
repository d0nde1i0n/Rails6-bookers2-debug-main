class Book < ApplicationRecord

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  validates :score,presence:true

  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :book_tags, dependent: :destroy
  has_many :tags, through: :book_tags

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def save_tags(savebook_tags)
    # 現在のユーザのユーザが所持しているタグを引っ張る
    # pluck:引数に指定したカラムの値を配列で返してくれるメソッド
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    # bookに今紐づいている現在のタグと新たに保存しようとしているタグの差分が古いタグ
    old_tags = current_tags - save_tags
    # 今回保存されるタグから現在のタグとの差が新しいタグ
    new_tags = savebook_tags - current_tags

    # 古いタグの削除
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name:old_name)
    end

    # 新しいタグの作成
    new_tags.each do |new_name|
      book_tag = Tag.find_or_create_by(name:new_name)
      # 配列にbookに紐づくtagを保存
      self.tags << book_tag
    end
  end

  def self.search_for(content, mathod)
    if method == 'perfect' #完全一致
      Book.where(title: content)
    elsif method == 'forward' #前方一致
      Book.wehre('title LIKE ?',content+'%');
    elsif method == 'backward' #後方一致
      Book.where('title LIKE ?','%'+content);
    else
      Book.where('title LIKE ?','%'+content+'%');
    end
  end
end
