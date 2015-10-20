require 'rails_helper'

RSpec.describe Todo, type: :model do
  before(:each) do
    @user = create(:user)
    @todo = create(:todo, creator: @user)
  end

  describe "#create" do
    context "when create a todo" do
      it "should create related event" do
        event = Event.last

        expect(event.todo_id).to eq(@todo.id)
        expect(event.actor_id).to eq(@todo.creator_id)
        expect(event.project_id).to eq(@todo.project_id)
        expect(event.event_type).to eq(Event::TYPE_TODO_CREATE)
      end
    end
  end

  describe "#delete" do
    context "when delete a todo" do
      before do
        @title = @todo.title
        @todo.delete(@user.id)
      end

      it "should create related event" do
        event = Event.last

        expect(event.deleted_todo_title).to eq(@title)
        expect(event.actor_id).to eq(@user.id)
        expect(event.project_id).to eq(@todo.project_id)
        expect(event.event_type).to eq(Event::TYPE_TODO_DELETE)
      end
    end
  end

  describe "#complete" do
    context "when complete a todo" do
      before do
        @todo.complete(@user.id)
      end

      it "should create related event" do
        event = Event.last

        expect(event.todo_id).to eq(@todo.id)
        expect(event.actor_id).to eq(@user.id)
        expect(event.project_id).to eq(@todo.project_id)
        expect(event.event_type).to eq(Event::TYPE_TODO_COMPLETE)
      end
    end
  end

  describe "#assign_completer" do
    context "when assign a completer" do
      before do
        @other_user = create(:user)
        @todo.assign_completer(@user.id, @other_user.id)
      end

      it "should create related event" do
        event = Event.last

        expect(event.todo_id).to eq(@todo.id)
        expect(event.actor_id).to eq(@user.id)
        expect(event.project_id).to eq(@todo.project_id)
        expect(event.old_completer_id).to eq(nil)
        expect(event.new_completer_id).to eq(@other_user.id)
        expect(event.event_type).to eq(Event::TYPE_TODO_ASSIGN_COMPLETER)
      end
    end

    context "when assign a completer again" do
      before do
        @other_user = create(:user)

        @todo.assign_completer(@user.id, @other_user.id)
        @todo.assign_completer(@user.id, @user.id)
      end

      it "should create related event" do
        event = Event.last

        expect(event.todo_id).to eq(@todo.id)
        expect(event.actor_id).to eq(@user.id)
        expect(event.project_id).to eq(@todo.project_id)
        expect(event.old_completer_id).to eq(@other_user.id)
        expect(event.new_completer_id).to eq(@user.id)
        expect(event.event_type).to eq(Event::TYPE_TODO_CHANGE_COMPLETER)
      end
    end
  end

  describe "#change_deadline" do
    context "when change deadline" do
      before do
        @date_now = Date.current
        @todo.change_deadline(@user.id, @date_now)
      end

      it "should create related event" do
        event = Event.last

        expect(event.old_deadline).to eq(nil)
        expect(event.new_deadline).to eq(@date_now.to_formatted_s(:db))
        expect(event.actor_id).to eq(@user.id)
        expect(event.project_id).to eq(@todo.project_id)
        expect(event.event_type).to eq(Event::TYPE_TODO_CHANGE_DEADLINE)
      end
    end
  end

  describe "#add_comment" do
    context "when add comment to a todo" do
      before do
        @comment = Comment.new(
            content: Faker::Lorem.sentence,
            user_id: @user.id
        )
        @todo.comments << @comment
        @todo.save
      end

      it "should create related event" do
        event = Event.last

        expect(event.actor_id).to eq(@user.id)
        expect(event.todo_id).to eq(@todo.id)
        expect(event.project_id).to eq(@todo.project_id)
        expect(event.event_type).to eq(Event::TYPE_TODO_ADD_COMMENT)
      end
    end
  end
end