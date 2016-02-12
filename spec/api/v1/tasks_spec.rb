require 'rails_helper'

RSpec.describe Api::V1::TasksController, type: :controller do
  let!(:task_list) { create(:task_list) }
  let(:task) { create(:task, task_list: task_list) }

  describe 'GET #show' do
    context "authenticated user" do
      login_user
      
      let!(:comment) { create(:comment, task: task) }

      before {get :show, id: task, format: :json }

      it 'returns 200 status code' do
        expect(response.status).to eq 200
      end

      %w(id description completed position deadline).each do |attr|
        it "contains #{attr}" do
          expect(response.body).to be_json_eql(task.send(attr.to_sym).to_json).at_path("task/#{attr}")
        end
      end

      context 'comments' do
        it 'included in task object' do
          expect(response.body).to have_json_size(1).at_path('task/comments')
        end
        
        %w(id body file_attachment).each do |attr|
          it "contains #{attr}" do
            expect(response.body).to be_json_eql(comment.send(attr.to_sym).to_json).at_path("task/comments/0/#{attr}")
          end
        end
      end
    end
    it_behaves_like "authenticable" do
      before { get :show, id: task, format: :json }
    end
  end

  describe 'POST #create' do
    context "authenticated user" do
      login_user
      context 'with valid attributes' do
          it 'returns created status' do
            post :create, task: attributes_for(:task, task_list_id: task_list.id), format: :json
            expect(response).to be_success
          end
          it 'creates new task' do
            expect {
                post :create, task: attributes_for(:task, task_list_id: task_list.id), format: :json
              }.to change(task_list.tasks, :count).by(1)
          end
       end

      context 'with invalid attributes' do
        it 'returns 422 status code' do
          post :create, task: attributes_for(:invalid_task), format: :json
          expect(response.status).to eq 422
        end

        it 'does not save the task_list in the database' do
          expect { 
              post :create, task: attributes_for(:invalid_task), format: :json 
            }.to_not change(task_list.tasks, :count)
        end
      end
    end
    it_behaves_like "authenticable" do
      before do
        post :create, task: attributes_for(:task, task_list_id: task_list.id), format: :json
      end
    end
  end

  describe 'PATCH #update' do
    context "authenticated user" do
      login_user

      context 'with valid attributes' do
        before do
          patch :update, id: task, task: {description: "updated desc"}, format: :json
        end

        it "should return 204 OK" do
          expect(response).to be_success
        end

        it 'changes task_list attributes' do
          task.reload
          expect(task.description).to eq("updated desc")
        end
      end

      context 'with invalid attributes' do
        before do
          patch :update, id: task, task: {description: nil}, format: :json
        end

        it 'does not changes task_list attributes' do
          task.reload
          expect(task.description).to eq("MyString")
        end
      end
    end
    it_behaves_like "authenticable" do
      before do
        patch :update, id: task, task: {description: "updated desc"}, format: :json
      end
    end
  end

  describe "DELETE #destroy" do
    context "authenticated user" do
      login_user

      before do
        delete :destroy, id: task, format: :json
      end

      it "should remove a task from the database" do        
        expect { task.reload }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it "should return 200 OK" do
        expect(response).to be_success
      end

      it "should raise RecordNotFound when trying to destroy non-existent task" do
        expect { delete :destroy, id: 0, format: :json }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
    it_behaves_like "authenticable" do
      before do
        delete :destroy, id: task, format: :json
      end
    end
  end

  describe 'PATCH #sort' do
    context "authenticated user" do
      login_user

      it 'set task position' do
        patch :sort, id: task, position: 2, format: :json
        task.reload
        expect(task.position).to_not eq(1)
      end

      it "should return 204 OK" do
        patch :sort, id: task, position: 2, format: :json
        expect(response).to be_success
      end
    end
    it_behaves_like "authenticable" do
      before do
        patch :sort, id: task, position: 2, format: :json
      end
    end
  end
end