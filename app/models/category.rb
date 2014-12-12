class Category < ActiveRecord::Base
  has_many :pages

  validates :name, presence: true, length: { minimum: 2 }

  def display_name
    name.underscore.humanize
  end
end
