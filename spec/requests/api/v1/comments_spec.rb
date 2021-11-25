RSpec.describe Api::V1::CommentsController, type: :request do
  include_context 'with authorization'
  let(:project) { create(:project, user: user) }
  let(:task) { create(:task, project: project) }

  describe 'POST #create' do
    let(:comment_valid_params) { attributes_for(:comment, task_id: task.id) }
    let(:comment_invalid_params) { comment_valid_params.merge(name: '') }

    context 'with valid params' do
      it 'creates new comment' do
        expect { post api_v1_task_comments_path(comment_valid_params), headers: auth_params }
          .to change(Comment, :count).by(1)
        expect(response).to match_response_schema('comment_create')
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid params' do
      it 'does not create comment' do
        expect { post api_v1_task_comments_path(comment_invalid_params), headers: auth_params }
          .not_to change(Comment, :count)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:comment) { create(:comment, task: task) }

    it 'destroys comment' do
      expect { delete api_v1_comment_path(id: comment.id), headers: auth_params }
        .to change(Comment, :count).by(-1)
    end
  end
end
