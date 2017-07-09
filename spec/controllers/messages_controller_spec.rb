require 'rails_helper'
describe MessagesController, type: :controller do
  let(:user) { create(:user) }
  let(:group) { create(:group) }
  let(:messages) { create(:message) }

  describe 'GET #index' do
    context "ログインしている場合" do
      before do
        login_user user
        get :index, params: { group_id: group }
      end

      example "@messagesの検証" do
        messages = create_list(:message, 3, user_id: user.id, group_id: group.id)
        expect(assigns(:messages)).to match(messages)
      end

      example "@groupの検証" do
        expect(assigns(:group)).to eq(group)
      end

      example "@groupsの検証" do
        groups = user.groups
        expect(assigns(:groups)).to match(groups)
      end

      example "@messageの検証" do
        message = Message.new
        expect(assigns(:message)).to be_a_new(Message)
      end

      example "indexテンプレート表示の検証" do
        expect(response).to render_template :index
      end
    end

    context "ログインしていない場合" do
      it "ログインページへのリダイレクトの検証" do
        get :index, params: { group_id: group }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
  describe 'POST #create' do
    context "ログインしている場合" do
      before do
        login_user user
      end

      example "メッセージ正常保存の検証" do
        expect{post :create, params:{message: attributes_for(:message, user_id: user.id, group_id: group.id), group_id: group.id}}.to change(Message, :count).by(1)
      end

      example "投稿ページへのリダイレクト検証" do
        post :create, params:{message: attributes_for(:message, user_id: user.id, group_id: group.id), group_id: group.id}
        expect(response).to redirect_to group_messages_path(group)
      end

      example "メッセージの保存失敗の検証" do
        expect do
          post :create, params: { group_id: group, message: attributes_for(:message, body: nil, image: nil) }
        end.to change(Message, :count).by(0)
      end

      example "メッセージボックスが空のときの検証" do
        post :create, params: { group_id: group, message: attributes_for(:message, body: nil, image: nil) }
        expect(flash[:alert]).not_to be_empty
      end
    end

    context "ログインしていない場合" do
      it "ログインページにリダイレクトされること" do
         post :create, params: {group_id: group, message: attributes_for(:message)}
         expect(response).to redirect_to new_user_session_path
      end
    end
  end
end















