module BooksHelper
  # 第1引数 column:DB上のテーブルのカラム名
  # 第2引数 title:Viewに表示するカラム名
  def sort_order(column, title)
    direction = (column == sort_column && sort_direction == 'asc') ? 'desc' : 'desc'
    # 「モデルのカラム名=sort_column」かつsort_direction=asc(昇順)の場合はdesc（降順）,
    # それ以外の時はdescで返す(今回のみ降順に対応するため必ずdescになるようにしている。)
    link_to title, { sort: column, direction: direction }
  end
end
