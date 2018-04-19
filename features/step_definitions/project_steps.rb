require 'json'

Given /^I create a new project with complete parameters$/ do
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

Then /^I should see a new project created$/ do
  expect(Configuration.count).to eql(3)
  expect(Resource.count).to eql(2)
  expect(Project.count).to eql(1)
end