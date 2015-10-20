class EventsController < ApplicationController
  before_action :authenticate_user!

  DEFAULT_LIMIT = 50

  def index
    limit = (params[:limit] || DEFAULT_LIMIT).to_i
    offset = params[:offset] || 0
    actor_id = params[:actor_id]

    @events = Event.where(project_id: current_user.projects.map(&:id))
    @total = @events.count
    @events = @events.limit(limit).offset(offset)
    @events = @events.where(actor_id: actor_id) if actor_id
  end
end
