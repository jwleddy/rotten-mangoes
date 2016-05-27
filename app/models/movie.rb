class Movie < ActiveRecord::Base

  has_many :reviews

  validates :title, presence: true
  validates :director, presence: true
  validates :runtime_in_minutes, numericality: { only_integer: true }
  validates :description, presence: true
  validates :poster_image_url, presence: true
  validates :release_date, presence: true
  validate :release_date_is_in_the_past

  mount_uploader :poster_image, PosterImageUploader

  scope :search_title_director, ->(term) { where('upper(title) LIKE ? OR upper(director) LIKE ?', term, term) }
  scope :under_90, -> { where('runtime_in_minutes <= 90') }
  scope :between_90_120, -> { where('runtime_in_minutes > 90 and runtime_in_minutes <= 120') }
  scope :over_120, -> { where('runtime_in_minutes > 120') }

  def review_average
    if reviews.size > 0
      (reviews.sum(:rating_out_of_ten)/reviews.size.to_f).round(1)
    else
      0
    end
  end

  protected

  def release_date_is_in_the_past
    if release_date.present?
      errors.add(:release_date, "should be in the past") if release_date > Date.today
    end
  end
end
