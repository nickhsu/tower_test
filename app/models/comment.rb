class Comment < ActiveRecord::Base
  belongs_to :todo
  belongs_to :user

  after_create do
    Event.create(
        actor_id: user_id,
        todo_id: todo_id,
        project_id: todo.project.id,
        event_type: Event::TYPE_TODO_ADD_COMMENT
    )
  end
end
