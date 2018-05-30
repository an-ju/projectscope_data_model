class Project < ApplicationRecord
  has_many :activities
  has_many :resources
  has_many :events

  include EventParser

  def self.build(params)
    p = Project.create(specifier: params['specifier'])
    resources = params.delete 'resources'
    resources.each { |res| Resource.build(p, res) } unless resources.nil?
  end

  def create_event(event_type, payload)
    param = send event_type, payload
    event = Event.new(param)
    event.order = next_order
    events << event
  end

  def new_events(user)
    max_order = Activity.where(user_id: user.id, project_id: id).map(&:event_order).max
    new_events = events.order(:order)
    new_events = new_events.select { |e| e.order > max_order } unless max_order.nil?
    unless new_events.empty?
      Activity.create(user_id: user.id,
                      project_id: id,
                      event_order: new_events.last.id)
    end
    new_events
  end

  private

  def next_order
    return 1 if events.empty?
    events.map(&:order).max.next
  end

end
