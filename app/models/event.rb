class Event < ActiveRecord::Base

  # event types
  TYPE_TODO_CREATE = "type_todo_create"
  TYPE_TODO_DELETE = "type_todo_delete"
  TYPE_TODO_COMPLETE = "type_todo_complete"
  TYPE_TODO_ASSIGN_COMPLETER = "type_todo_assign_completer"
  TYPE_TODO_CHANGE_COMPLETER = "type_todo_change_complter"
  TYPE_TODO_CHANGE_DEADLINE = "type_todo_chage_deadline"
  TYPE_TODO_ADD_COMMENT = "type_todo_add_comment"
  TYPE_TODO_REOPEN = "type_todo_reopen"

  #relations
  belongs_to :actor, class_name: "User", foreign_key: :actor_id

  store :extentions,
        accessors: [
            :deleted_todo_title,
            :old_completer_id,
            :new_completer_id,
            :old_deadline,
            :new_deadline,
            :comment_id,
            :todo_id
        ],
        coder: JSON
end
