require 'json'

Given('I create a new project with complete parameters') do
  # TODO: Implement with factories
  params = {
    specifier: 'the specifier',
    resources: [{
      name: 'github',
      configurations: [{
        name: 'token',
        value: 'fake token'
      }, {
        name: 'identifier',
        value: 'user/loc'
      }]
    }, {
      name: 'pivotal_tracker',
      configurations: [{
        name: 'token',
        value: 'fake token'
      }]
    }]
  }
  headers = { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' }
  post '/projects', project: params, headers: headers
end

Given('the following projects exist') do |projects|
  projects.hashes.each do |p|
    Project.create(p)
  end
end

Given('the following resources exist') do |resources|
  resources.hashes.each do |r|
    r['project_id'] = Project.where(specifier: r['project_id']).first.id
    Resource.create(r)
  end
end

Given('the following events exist') do |events|
  @events = events.hashes.map(&:dup)
  events.hashes.each do |e|
    e['project_id'] = Project.where(specifier: e['project_id']).first.id
    Event.create(e)
  end
end

Given('the following users exist') do |users|
  users.hashes.each do |user|
    User.create(user)
  end
end

Then('I should see a new project created') do
  # TODO: More checks?
  expect(Configuration.count).to eql(3)
  expect(Resource.count).to eql(2)
  expect(Project.count).to eql(1)
end

Given /^new event from (\w+) for (.*)$/ do |tool_name, project|
  p = Project.where(specifier: project).first
  generator = "#{tool_name}Generator".constantize.new
  req = generator.generate_event p
  post req[:url], req[:params], req[:headers]
end

Then /^I should see the new event added to database$/ do
  expect(Event.count).to eql(1)
end

Then /^I should see (\d+) events in the database of (.*)$/ do |num_proj, project|
  num_proj = num_proj.to_i
  p = Project.where(specifier: project).first
  expect(p.events.length).eql? num_proj
end

And /^event (\d+) of (.*) should have priority (\d+)$/ do |id, project, od|
  p = Project.where(specifier: project).first
  expect(p.events[id.to_i - 1].order).to eql(od.to_i)
end

Given /^I am user "(.*)"$/ do |token|
  @user_token = token
end

When /^I get all events for project "(.*)"$/ do |project|
  p = Project.where(specifier: project).first
  response = get URI.escape "/projects/#{p.id}/events/?token=#{@user_token}"
  @resp = response.body
end

Then /^I should receive all events belong to "(.*)"$/ do |project|
  events = @events.select { |e| e['project_id'].eql? project }
  expect(JSON.parse(@resp).length).to eql(events.length)
end
