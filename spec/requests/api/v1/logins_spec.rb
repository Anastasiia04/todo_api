RSpec.describe Api::V1::LoginsController, type: :request do
  let(:user) { create(:user) }

  describe 'POST #create' do
    context 'with valid params' do
      before do
        post api_v1_login_path(email: user.email, password: user.password)
      end

      it 'creates new session' do
        expect(JSON.parse(response.body).keys).to include('access', 'refresh')
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid params' do
      let(:invalid_password) { 'some_password' }

      before do
        post api_v1_login_path(email: user.email, password: invalid_password)
      end

      it 'does not create new session' do
        expect(JSON.parse(response.body).symbolize_keys).to eq(errors: 'Invalid user')
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
