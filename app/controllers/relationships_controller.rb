class RelationshipsController < ApplicationController
# ログインしていないユーザは本コントローラを参照できないようにする。
before_action :authenticate_user!

  def create
    # ログインユーザidとそのフォロー対象のユーザidを取得し、
    # 変数paramsに格納
    relationship = current_user.relationships.new(followed_id: params[:user_id])
    # relationshipsテーブルに必要な情報を全て格納できたため、DBに格納
    relationship.save
    # リダイレクト先はリンク元のページを指定
    redirect_to request.referer
  end

  def destroy
    # ログインユーザidとログインユーザがフォローしているユーザのidを取得し、
    # 変数paramsに格納
    relationship = current_user.relationships.find_by(followed_id: params[:user_id])
    # relationshipsテーブルのレコードの中から、変数followerに格納されている情報と
    # 一致するレコードを削除
    relationship.destroy
    # リダイレクト先はリンク元のページを指定
    redirect_to request.referer
  end

end
