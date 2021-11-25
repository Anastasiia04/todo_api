RSpec.describe Api::V1::ProjectsController, type: :request do
  include_context 'with authorization'

  describe 'GET #index' do
    let(:projects_count) { 3 }

    before do
      create_list(:project, projects_count, user: user)
      get api_v1_projects_path, headers: auth_params
    end

    it 'responds with success status' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders actual projects' do
      expect(response).to match_response_schema('project_index')
      expect(JSON.parse(response.body)['data'].size).to eq(projects_count)
    end
  end

  describe 'POST #create' do
    let(:project_valid_params) { attributes_for(:project, user_id: user.id) }
    let(:project_invalid_params) { project_valid_params.merge(name: '') }

    context 'with valid params' do
      it 'creates new user project' do
        expect { post api_v1_projects_path(project_valid_params), headers: auth_params }
          .to change(Project, :count).by(1)
        expect(response).to match_response_schema('project_create')
      end

      it 'has proper response status' do
        post api_v1_projects_path(project_valid_params), headers: auth_params
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid params' do
      it 'does not create project' do
        expect { post api_v1_projects_path(project_invalid_params), headers: auth_params }
          .not_to change(Project, :count)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      let(:new_name_for_project) { 'new name' }
      let(:project) { create(:project, user: user) }

      before do
        patch api_v1_project_path(id: project.id, name: new_name_for_project), headers: auth_params
      end

      it 'returns proper status' do
        expect(response).to have_http_status(:ok)
      end

      it 'updates project' do
        project.reload
        expect(project.name).to eq(new_name_for_project)
      end
    end

    context 'with invalid params' do
      let(:project) { create(:project, user: user) }

      before do
        patch api_v1_project_path(id: project.id, name: ''), headers: auth_params
      end

      it 'does not update project' do
        project.reload
        expect(project.name).not_to eq nil
      end

      it 'returns proper status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:project) { create(:project, user: user) }

    it "destroys user's project" do
      expect { delete api_v1_project_path(id: project.id), headers: auth_params }
        .to change(Project, :count).by(-1)
    end
  end
end
