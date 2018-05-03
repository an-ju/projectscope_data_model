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

  def new_event(event_type, payload)
    param = send event_type, payload
    event = Event.new(param)
    event.order = next_order
    events << event
  end

  private

  def next_order
    return 1 if events.empty?
    events.map(&:order).max.next
  end

end
