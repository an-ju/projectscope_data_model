class Project < ApplicationRecord
  has_many :activities
  has_many :resources

  def self.build(params)
    p = Project.create(specifier: params['specifier'])
    resources = params.delete 'resources'
    resources.each { |res| Resource.build(p, res) } unless resources.nil?
  end
end
