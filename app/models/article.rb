class Article < ActiveRecord::Base
  extend FriendlyId
  has_many :contents, dependent: :destroy
  has_many :tags, dependent: :destroy

  validates :name, :image, presence: true
  before_save { self.name = name.parameterize }

  has_attached_file :image, default_url: 'logo.png', styles: {thumb: '150x150#', large: '600x225#'}
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  friendly_id :name, use: :slugged

  def display_name
    name.underscore.humanize
  end
end
