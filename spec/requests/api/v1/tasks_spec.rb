RSpec.describe Api::V1::TasksController, type: :request do
  let(:user) { create(:user) }
  let(:payload) { { user_id: user.id } }
  let(:tokens) { JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true).login }
  let(:access_token) { tokens[:access] }
  let(:auth_params) { { 'Authorization' => "Bearer #{access_token}" } }
  let(:project) { create(:project, user: user) }

  describe 'POST #create' do
    let(:task_valid_params) { attributes_for(:task, project_id: project.id) }
    let(:task_invalid_params) { task_valid_params.merge(name: '') }

    context 'with valid params' do
      it 'creates new task' do
        expect { post api_v1_project_tasks_path(task_valid_params), headers: auth_params }
          .to change(Task, :count).by(1)
        expect(response).to match_response_schema('task_create')
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid params' do
      it 'does not create task' do
        expect { post api_v1_project_tasks_path(task_invalid_params), headers: auth_params }
          .not_to change(Task, :count)
      end
    end
  end

  describe 'PATCH #update' do
    let(:new_name_for_task) { 'new name' }
    let(:task) { create(:task, project: project) }

    context 'with valid params' do
      before do
        patch api_v1_task_path(id: task.id, name: new_name_for_task), headers: auth_params
      end

      it 'updates task' do
        task.reload
        expect(response).to match_response_schema('task_update')
        expect(task.name).to eq new_name_for_task
      end

      it 'has proper status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid params' do
      let(:task) { create(:task, project: project) }

      before do
        patch api_v1_task_path(id: task.id, name: ''), headers: auth_params
      end

      it 'does not update task' do
        task.reload
        expect(task.name).not_to eq nil
      end

      it 'has proper status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:task) { create(:task, project: project) }

    it 'destroys task' do
      expect { delete api_v1_task_path(id: task.id), headers: auth_params }
        .to change(Task, :count).by(-1)
    end
  end
end
