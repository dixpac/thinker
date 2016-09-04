class Story < ApplicationRecord
  belongs_to :user

  validates :title, :body, :user_id, presence: true

  scope :published, -> { where.not(published_at: nil) }


  def self.new_draft_for(user)
    post = self.new(user: user)
    post.save_draft
    post
  end

  def save_draft
    self.published_at = nil
    save(validate: false)
  end

  def published?
    published_at.present?
  end

  def publish
    self.published_at = Time.zone.now
    save
  end

  def unpublish
    self.published_at = nil
  end
end
