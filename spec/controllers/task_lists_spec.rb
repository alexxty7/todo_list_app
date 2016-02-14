require 'rails_helper'

RSpec.describe TaskListsController, type: :controller do
  let(:other_task_list) { create(:task_list, user: create(:user) ) } 

  describe 'GET #index' do
    
    context "authenticated user" do
      login_user

      let!(:task_lists) { create_list(:task_list, 2, user: @user) }
      let(:task_list) { task_lists.first }
      let!(:task) { create(:task, task_list: task_list) }

      before { get :index, format: :json }

      it 'returns 200 status code' do
        expect(response.status).to eq 200
      end

      it 'returns list of task_lists' do
        expect(response.body).to have_json_size(2).at_path('task_lists')
      end

      %w(id title).each do |attr|
        it "task_list object contains #{attr}" do
          expect(response.body).to be_json_eql(task_list.send(attr.to_sym).to_json).at_path("task_lists/0/#{attr}")
        end
      end

      context 'tasks' do
        it 'included in task_list object' do
          expect(response.body).to have_json_size(1).at_path('task_lists/0/tasks')
        end
        
        %w(id description completed position deadline).each do |attr|
          it "contains #{attr}" do
            expect(response.body).to be_json_eql(task.send(attr.to_sym).to_json).at_path("task_lists/0/tasks/0/#{attr}")
          end
        end
      end
    end

    it_behaves_like "authenticable" do
      before { get :index, format: :json }
    end
  end

  describe 'POST #create' do
    
    context "authenticated user" do
      login_user
      context 'with valid attributes' do
        let(:post_create) do
          post :create, task_list: attributes_for(:task_list), format: :json
        end

        it 'returns 201 status code' do
          post_create
          expect(response.status).to eq 201
        end

        it 'saves the new task_list in the database' do
          expect { post_create }.to change(TaskList, :count).by(1)      
        end
      end

      context 'with invalid attributes' do
        let(:post_create) do
          post :create, task_list: attributes_for(:invalid_task_list), format: :json
        end

        it 'returns 422 status code' do
          post_create
          expect(response.status).to eq 422
        end

        it 'does not save the task_list in the database' do
          expect { post_create }.to_not change(TaskList, :count)
        end
      end
    end

    it_behaves_like "authenticable" do
      before do
        post :create, task_list: attributes_for(:task_list), format: :json
      end
    end
  end

  describe 'PATCH #update' do
    let(:task_list) { create(:task_list, user: @user) }

    context "authenticated user" do
      login_user

      context 'with valid attributes' do
        before do
          patch :update, id: task_list, task_list: attributes_for(:task_list, title: "updated list"), format: :json
        end

        it "return 204 OK" do
          expect(response).to be_success
        end

        it 'changes task_list attributes' do
          task_list.reload
          expect(task_list.title).to eq("updated list")
        end

        it "return AccessDenied when trying to update task_list of another user" do
          expect { 
              patch :update, id: other_task_list, task_list: attributes_for(:task_list, title: "updated list"), format: :json
            }.to raise_error(CanCan::AccessDenied)
        end
      end

      context 'with invalid attributes' do
        before do
          patch :update, id: task_list, task_list: attributes_for(:task_list, title: nil), format: :json
        end

        it 'does not changes task_list attributes' do
          task_list.reload
          expect(task_list.title).to eq("MyString")
        end
      end
    end

    it_behaves_like "authenticable" do
      before do
        patch :update, id: other_task_list, task_list: attributes_for(:task_list, title: "updated list"), format: :json
      end
    end
  end

  describe "DELETE #destroy" do
    let(:task_list) { create(:task_list, user: @user) }

    context "authenticated user" do
      login_user

      before do
        delete :destroy, id: task_list, format: :json
      end

      it "remove a task_list from the database" do        
        expect { task_list.reload }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it "return 200 OK" do
        expect(response).to be_success
      end

      it "raise RecordNotFound when trying to destroy non-existent task" do
        expect { delete :destroy, id: 0, format: :json }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it "return AccessDenied when trying to delete task_list of another user" do
        expect { 
            delete :destroy, id: other_task_list, format: :json
          }.to raise_error(CanCan::AccessDenied)
      end
    end

    it_behaves_like "authenticable" do
      before do
        delete :destroy, id: other_task_list, format: :json      
      end
    end
  end
end