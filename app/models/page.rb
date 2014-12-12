class Page < ActiveRecord::Base
  has_many :contents, dependent: :destroy
  has_many :tags, dependent: :destroy
  belongs_to :category

  validates :name, presence: true

  extend FriendlyId
  friendly_id :name, use: :slugged

  def content(name)
    contents.find_by(name: name)
  end

  def display_name
    name.underscore.humanize
  end
end
