class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :role, :secure_code, :secure_code_id
  attr_accessor :secure_code, :secure_code_id
  has_one :secret_code

  #CONSTANT
  ROLE = ["admin", "user"]

  validate :check_code
  before_create :set_user_role
  after_create :set_code

  private

  def set_user_role
    self.role = ROLE[1]
  end

  def check_code
    errors.add(:base, "Code not found") if self.secure_code_id.blank?
    errors.add(:base, "Code not matched") if SecretCode.find(self.secure_code_id).code != self.secure_code
  end

  def set_code
    SecretCode.find(self.secure_code_id).update_attribute(:user_id, self.id)
  end
end
