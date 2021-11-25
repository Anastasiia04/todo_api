RSpec.describe Api::V1::RefreshesController, type: :request do
  let(:user) { create(:user) }
  let(:payload) { { user_id: user.id } }
  let(:tokens) { JWTSessions::Session.new(payload: payload, refresh_payload: payload).login }
  let(:refresh_token) { tokens[:refresh] }
  let(:auth_params) { { 'X-Refresh-Token' => "Bearer #{refresh_token}" } }

  describe 'POST #create' do
    before do
      post api_v1_refresh_path, headers: headers
    end

    context 'when valid headers' do
      let(:headers) { auth_params }

      it 'creates new access token' do
        expect(JSON.parse(response.body).keys).to include('access')
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when invalid headers' do
      let(:headers) { {} }

      it 'returns unauthorized response status' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
