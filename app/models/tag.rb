class Tag < ActiveRecord::Base
  belongs_to :article
  belongs_to :page
end
