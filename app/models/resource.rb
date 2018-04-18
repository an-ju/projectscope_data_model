class Resource < ApplicationRecord
  has_many :events
  has_many :configurations

  belongs_to :project
end
