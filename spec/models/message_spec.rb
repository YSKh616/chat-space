require 'rails_helper'
describe Message do

  describe '#create' do
      example "メッセージを保存できるとき" do
        message = build(:message)
        expect(message).to be_valid
      end

      context "メッセージを保存できないとき" do
        example "メッセージも画像もないとき" do
          @message = build(:message, body:"", image: nil)
          @message.valid?
          expect(@message.errors[:body]).to include('を入力してください')
        end

        example "ユーザIDがないとき" do
          message = build(:message, user_id: nil)
          message.valid?
          expect(message.errors[:user_id]).to include('を入力してください')
        end

        example "グループIDがないとき" do
          message = build(:message, group_id: nil)
          message.valid?
          expect(message.errors[:group_id]).to include('を入力してください')
        end
      end
  end
end