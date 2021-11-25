RSpec.shared_context 'with authorization' do
  let(:user) { create(:user) }
  let(:payload) { { user_id: user.id } }
  let(:tokens) { JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true).login }
  let(:access_token) { tokens[:access] }
  let(:auth_params) { { 'Authorization' => "Bearer #{access_token}" } }
end
