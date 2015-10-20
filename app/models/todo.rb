class Todo < ActiveRecord::Base
  belongs_to :project
  belongs_to :creator, class_name: :User, foreign_key: :creator_id
  belongs_to :executor, class_name: :User, foreign_key: :executor_id
  belongs_to :completer, class_name: :User, foreign_key: :completer_id

  has_many :comments
  belongs_to :project

  after_create do
    Event.create(
        actor_id: creator_id,
        todo_id: id,
        project_id: project.id,
        event_type: Event::TYPE_TODO_CREATE
    )
  end

  def delete(actor_id)
    Event.create(
        actor_id: actor_id,
        todo_id: id,
        project_id: project.id,
        deleted_todo_title: title,
        event_type: Event::TYPE_TODO_DELETE
    ) if destroy
  end

  def complete(actor_id)
    Event.create(
        actor_id: actor_id,
        todo_id: id,
        project_id: project.id,
        event_type: Event::TYPE_TODO_COMPLETE
    ) if update(completed: true)
  end

  def assign_completer(actor_id, new_completer_id)
    data = {
        actor_id: actor_id,
        todo_id: id,
        project_id: project.id,
        old_completer_id: nil,
        new_completer_id: new_completer_id,
        event_type: Event::TYPE_TODO_ASSIGN_COMPLETER
    }
    if completer_id
      data[:old_completer_id] = completer_id
      data[:event_type] = Event::TYPE_TODO_CHANGE_COMPLETER
    end

    Event.create(data) if update(completer_id: new_completer_id)
  end

  def change_deadline(actor_id, new_deadline)
    old_deadline = deadline
    Event.create(
        actor_id: actor_id,
        todo_id: id,
        project_id: project.id,
        old_deadline: old_deadline,
        new_deadline: new_deadline,
        event_type: Event::TYPE_TODO_CHANGE_DEADLINE
    ) if update(deadline: new_deadline)
  end
end
