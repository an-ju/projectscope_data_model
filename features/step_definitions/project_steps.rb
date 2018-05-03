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
    r['project_id'] = Project.where(specifier: r['project_id']).first
    Resource.create(r)
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
