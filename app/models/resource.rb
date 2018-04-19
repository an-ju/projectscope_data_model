class Resource < ApplicationRecord
  has_many :events
  has_many :configurations

  belongs_to :project

  def self.build(proj, rparams)
    res = Resource.create(project: proj, name: rparams['name'], meta: rparams['meta'])
    configs = rparams.delete('configurations')
    configs.each { |c| Configuration.create(resource: res, name: c['name'], value: c['value']) } unless configs.nil?
  end
end
