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

  # A method delete a todo and create a related event
  # @param [User] :actor event actor
  # return the object
  def delete(actor)
    Event.create(
        actor_id: actor.id,
        todo_id: id,
        project_id: project.id,
        deleted_todo_title: title,
        event_type: Event::TYPE_TODO_DELETE
    ) if destroy

    self
  end

  # A method complete a todo and create a related event
  # @param [User] :actor event actor
  # return the object
  def complete(actor)
    Event.create(
        actor_id: actor.id,
        todo_id: id,
        project_id: project.id,
        event_type: Event::TYPE_TODO_COMPLETE
    ) if update(completed: true)

    self
  end


  # A method assign a todo to a  completer and create a related event
  # @param [Integer] :actor_id event actor
  # @param [Integer] :new_completer_id new completer
  # return the object
  def assign_completer(actor, new_completer)
    data = {
        actor_id: actor.id,
        todo_id: id,
        project_id: project.id,
        old_completer_id: nil,
        new_completer_id: new_completer.id,
        event_type: Event::TYPE_TODO_ASSIGN_COMPLETER
    }
    if completer_id
      data[:old_completer_id] = completer.id
      data[:event_type] = Event::TYPE_TODO_CHANGE_COMPLETER
    end

    Event.create(data) if update(completer_id: new_completer.id)

    self
  end

  # A method change deadline of a todo and create a related event
  # @param [Integer] :actor_id event actor
  # @param [Date] :new_deadline new deadline
  # return the object
  def change_deadline(actor, new_deadline)
    old_deadline = deadline
    Event.create(
        actor_id: actor.id,
        todo_id: id,
        project_id: project.id,
        old_deadline: old_deadline,
        new_deadline: new_deadline,
        event_type: Event::TYPE_TODO_CHANGE_DEADLINE
    ) if update(deadline: new_deadline)

    self
  end
end
