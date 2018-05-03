require 'cucumber/rspec/doubles'
require 'json'

class BaseGenerator
end

# Generator for GitHub APIs
class GitHubGenerator < BaseGenerator

  def events_push
    # Mocked API for GitHub Events API
    # Doc: https://developer.github.com/v3/activity/events/
    RSpec::Mocks.with_temporary_scope do

    end
  end

  def generate_event(project)
    create_event project
  end

  def create_event(project)
    headers = {
      'X-GitHub-Event' => 'create',
      # 'X-GitHub-Delivery' => '72d3162e-cc78-11e3-81ab-4c9367dc0958',  # this field is not used
      'Content-Type' => 'application/json'
    }
    params = JSON.parse(File.read('features/support/fake_replies/github/creat.json'))
    {
      url: "/projects/#{project.id}/events",
      params: params,
      headers: headers
    }
  end

  def create_events(event_sequence)
    template = File.read('features/support/fake_replies/github/event.erb')
    events = event_sequence.map do |event_type|
      payload = File.read "features/support/fake_replies/github/#{event_type}.json"
      ERB.new(template).result(binding)
    end
    "[#{events.join(',')}]"
  end
end