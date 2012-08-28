class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # , :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :company_name

  has_one :company, dependent: :destroy
  attr_accessor :company_name

  after_create :create_company

  private

  def create_company
    c = Company.new name: self.company_name
    c.user_id = self.id
    c.save!
    c
  end
end
