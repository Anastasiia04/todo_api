RSpec.describe Api::V1::UsersController, type: :request do
  describe 'POST #create' do
    let(:user_params) { attributes_for(:user) }
    let(:user_invalid_params) { attributes_for(:user, email: '') }

    context 'with valid params' do
      it 'creates new user' do
        expect { post api_v1_users_path(user_params) }.to change(User, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'does not create user' do
        expect { post api_v1_users_path(user_invalid_params) }.not_to change(User, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'with dublicate of email' do
      let(:some_email) { FFaker::Internet.email }
      let(:invalid_params) { attributes_for(:user, email: some_email) }

      before do
        create(:user, email: some_email)
      end

      it 'does not create user' do
        expect { post api_v1_users_path(user_invalid_params) }.not_to change(User, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
