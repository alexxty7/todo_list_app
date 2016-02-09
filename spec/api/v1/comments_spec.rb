require 'rails_helper'

RSpec.describe Api::V1::CommentsController, type: :controller do
  let(:task_list) { create(:task_list) }
  let!(:task) { create(:task, task_list: task_list) }

  describe 'POST #create' do

     context 'with valid attributes' do
        it 'returns created status' do
          post :create, comment: attributes_for(:comment, task_id: task.id), format: :json
          expect(response).to be_success
        end
        it 'creates new comment' do
          expect {
              post :create, comment: attributes_for(:comment, task_id: task.id), format: :json
            }.to change(task.comments, :count).by(1)
        end
     end

    context 'with invalid attributes' do
      it 'returns 422 status code' do
        post :create, comment: attributes_for(:invalid_comment), format: :json
        expect(response.status).to eq 422
      end

      it 'does not save the task_list in the database' do
        expect { 
            post :create, comment: attributes_for(:invalid_comment), format: :json 
          }.to_not change(task.comments, :count)
      end
    end
  end


  describe "DELETE #destroy" do
    let(:comment) { create(:comment, task: task) }

    before do
      delete :destroy, id: comment, format: :json
    end

    it "should remove a task from the database" do        
      expect { comment.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "should return 200 OK" do
      expect(response).to be_success
    end

    it "should raise RecordNotFound when trying to destroy non-existent task" do
      expect { delete :destroy, id: 0, format: :json }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end