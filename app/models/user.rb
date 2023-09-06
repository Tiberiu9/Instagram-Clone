class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  has_many :posts

  has_many :comments

  has_one_attached :avatar

  before_create :randomize_id

  private

  def randomize_id
    begin
      self.id = SecureRandom.random_number(1_000_000_000)
    end while User.where(id:).exists?
  end

  # Validations
  # Email validations----------------
  validates :email, presence: true, length: { maximum: 254 }, format: { with: URI::MailTo::EMAIL_REGEXP }

  # # Password validations-------------
  PASSWORD_FORMAT = /\A
    (?=.*[A-Z]) # Must contain an uppercase character
    (?=.*[a-z]) # Must contain a lowercase character
    (?=.*\d) # Must contain a digit
    # (?=.*[[:^alnum:]]) # Must contain a symbol
  /x

  validates :password, presence: true, length: { minimum: 8, maximum: 128 },
                       format: { with: PASSWORD_FORMAT, message: 'must include: 1 uppercase, 1 lowercase and 1 digit'}
end
