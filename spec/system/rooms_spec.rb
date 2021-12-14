require 'rails_helper'

RSpec.describe 'チャットルームの削除機能', type: :system do
  before do
    @room_user = FactoryBot.create(:room_user)
  end

  it 'チャットルームを削除すると、関連するメッセージがすべて削除されている' do
    # サインインする
    sign_in(@room_user.user)

    # 作成されたチャットルームへ遷移する
    click_on(@room_user.room.name)

    # メッセージ情報を5つDBに追加する
    FactoryBot.create_list(:message, 5, room_id: @room_user.room.id, user_id: @room_user.user.id)
      # create_list  FactoryBotの設定ファイルに存在しているレコードを、複数作成したい場合に使用するメソッド
      #第１引数には作成したいインスタンスをシンボル型で記述し、第２引数に作成するレコードの個数を数値を設定する
    
    # 「チャットを終了する」ボタンをクリックすることで、作成した5つのメッセージが削除されていることを確認する
    expect {find_link('チャットを終了する', href: room_path(@room_user.room)).click}.to change { @room_user.room.messages.count }.by(-5)
    # トップページに遷移していることを確認する
    expect(current_path).to eq(root_path)
  end
end