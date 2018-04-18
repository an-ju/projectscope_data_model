class Project < ApplicationRecord
  has_many :activities
  has_many :resources
end
