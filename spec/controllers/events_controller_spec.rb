require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = FactoryGirl.create(:user)
    @team = create(:team)
    sign_in @user
  end

  it "user shoud login" do
    expect(subject.current_user).not_to eql(nil)
  end

  describe "#index" do
    render_views

    before do
      @project = create(:project, team: @team, users: Array(@user))
      @todos = create_list(:todo, 10, project: @project, creator: @user)
    end

    context "using default paramse" do
      it "should recurn correct number of events" do
        get :index, format: :json

        json_data = JSON.parse(response.body)

        expect(json_data["total"]).to eq(10)
        expect(json_data["events"].length).to eq(10)
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
    end

    context "using limit paramse" do
      it "should recurn correct number of events" do
        get :index, format: :json, limit: 5

        json_data = JSON.parse(response.body)

        expect(json_data["events"].length).to eq(5)
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
    end


    context "using offset paramse" do
      it "should recurn correct events" do
        get :index, format: :json, limit: 5, offset: 1

        json_data = JSON.parse(response.body)

        expect(json_data["events"].length).to eq(5)
        expect(json_data["events"].first["extentions"]["todo_id"]).to eq(@todos[1].id)
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
    end

    context "after other user create todos in other project" do
      before do
        @other_user = create(:user)
        @project = create(:project, team: @team, users: Array(@other_user))
        @todos = create_list(:todo, 10, project: @project, creator: @other_user)
      end

      it "should recurn same number of events" do
        get :index, format: :json

        json_data = JSON.parse(response.body)

        expect(json_data["events"].length).to eq(10)
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
    end

    context "after other user create todos in the same project" do
      before do
        @other_user = create(:user)
        create(:access, user: @other_user, project: @project)
        @todos = create_list(:todo, 10, project: @project, creator: @other_user)
      end

      it "should recurn same number of events" do
        get :index, format: :json

        json_data = JSON.parse(response.body)

        expect(json_data["events"].length).to eq(20)
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      context "using creator_id paramter" do
        it "should recurn correct number of events" do
          get :index, format: :json, actor_id: @other_user.id

          json_data = JSON.parse(response.body)

          expect(json_data["events"].length).to eq(10)
          expect(json_data["events"].first["actor_id"]).to eq(@other_user.id)
          expect(response).to be_success
          expect(response).to have_http_status(200)
        end
      end
    end

  end
end
