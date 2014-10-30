class Content < ActiveRecord::Base
  belongs_to :page
  belongs_to :article
  validates :value, presence: true, if: Proc.new {|c| ['content_text', 'content_right', 'content_left', 'content_embed'].index(c.partial) }

  has_attached_file :image
  has_attached_file :file
  has_attached_file :image, styles: {thumb: '220x220#'}

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  before_create do
    associate = self.page || self.article
    positions = associate.contents.map {|c| c.position}
    positions.empty? ? self.position = 1 : self.position = positions.max + 1
  end

  def increment_position!
    associate = self.page || self.article
    unless position == 1
      next_content = associate.contents.find_by position: (position - 1)
      decrement! :position
      next_content.increment!(:position) if next_content
    end

    self
  end

  def decrement_position!
    associate = self.page || self.article
    
    other_contents = associate.contents.where.not(id: id)

    if position < other_contents.map {|c| c.position}.max
      previous_content = other_contents.find_by position: (position + 1)
      increment! :position
      previous_content.decrement!(:position) if previous_content
    end

    self
  end

  def thumb
    thumb_image = image.url(:thumb)
    if thumb_image.index 'missing.png'
      nil
    else
      thumb_image
    end
  end

  AVAILABLE_SELECT_PARTIALS = [['Texte seul', 'content_text'], ['Image à gauche', 'content_left'], ['Image à droite', 'content_right'], ['Lien embed', 'content_embed']]
end
