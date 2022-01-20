# README

This README would normally document whatever steps are necessary to get the
application up and running.

#修正点1
  【エラー内容など】
    サーバー起動後、「Bloked host:~」というエラーが発生
  【対処内容】
    エラーが表示されたページの「config.hosts << 〜」を書きファイルに記載。
  【対象ファイル】
    config/enviroments/developments.rb

#修正点2
  【エラー内容など】
    routes.rbを開いた時、SyntaxError発生
  【対処内容】
    最終行に「end」を追記
  【対象ファイル】
    config/routes.rb

#修正点3
　【エラー内容など】
    users_controller.rbを開いた時、SyntaxError発生
  【対処内容】
    indexアクションの最終行に「end」を追記
  【対象ファイル】
    app/controllers/users_controller.rb

#修正点4
  【エラー内容など】
  　サーバー起動後、「〜でリダイレクトが繰り返し行われました。」と表示されてしまう。
  【対処内容】
  　「before_action :authenticate_user!」の影響で
  　ログイン済みユーザ以外は全ページ表示できないようになっているため
  　ログインしていないユーザがtop、aboutページを閲覧可能となるように修正
  【対象ファイル】
    app/controllers/application_controller.rb

#修正点5
　【エラー内容など】
　  top画面の「Log in」ボタンを選択後、下記エラーが発生。
　  「undefined local variable or method `new_user_sessions_path」
　【対処内容】
　  top画面の「Log in」,「Sign up」ボタン選択後の遷移先パスを修正
　【対象ファイル】
　  app/views/homes/top.html.erb

#修正点6
  【エラー内容】
    top画面の「Sign up」ボタンを選択後、下記エラーが発生。
    「undefined method `name_field'」
  【対処内容】
    メソッド名を修正
  【対象ファイル】
    app/views/devises/registration/new.html.erb

#修正点7
  【エラー内容など】
  　htmlのmain部分が表示されない。
  【対処内容】
    各viewの設定内容をmain部分に反映させるために、下記ファイルに<%= yield %>を追記
  【対象ファイル】
    app/views/layouts/application.html.erb


#修正点8
  【エラー内容など】
    Sign upしようとすると、「Books must exist」と表示されユーザ登録できない。
  【対処内容】
    モデルUserとBookのアソシエーションについての記述を修正。
    （正しいアソシエーション関係とは逆関係となるような記述がされていた。）
  【対象ファイル】
    app/models/user.rb
    app/models/book.rb

#修正点9
　【エラー内容など】
　  Sign up後の遷移先が、Top画面になっている。
　【対処内容】
　  Sign up後の遷移先が、User詳細画面になるように遷移先となるパスを修正
　 【対象ファイル】
　  app/controllers/application_controller.rb

#修正点10
  【エラー内容など】
    ユーザ一覧画面に遷移しようとしたところ、下記エラーが発生。
    「ActionView::MissingTemplate in Users#index」
  【対処内容】
    renderで指定しているurlの記述に不足があるため修正。
  【対象ファイル】
    app/views/users/index.html.erb

#修正点11
  【エラー内容など】
    ユーザ一覧画面のレイアウトが本の投稿一覧と異なる。
  【対処内容】
    bootstrapのグリッドシステム関連の修正を下記ファイルに実施。
  【対象ファイル】
    app/views/users/index.html.erb

#修正点12
  【エラー内容など】
    新規投稿時、下記のようなエラーが発生
    「param is missing or the value is empty: book」
  【対処内容】
    bookのpermit対象となるカラムを追加
  【対象ファイル】
  　app/controllers/books_controller.rb

#修正点13
　【エラー内容など】
　  ユーザ編集画面に遷移できず、変数「obj」がnil（空）というエラーが発生。
　【対処内容】
　  viewに引き渡すためのインスタンス変数を下記ファイルに追記。
　【対象ファイル】
　  app/controllers/users_controller/rb

#修正点14
　【エラー内容など】
　  ユーザ編集画面の編集項目「Title」というカラムが存在しない。
　【対処内容】
　  必要なカラム名は「name」のため、下記ファイルを修正
　【対象ファイル】
　  app/views/users/edit.html.erb

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
