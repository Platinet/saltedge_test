
RSpec.describe User, type: :model do
  it { expect have_attribute :email }
  it { expect have_attribute :encrypted_password }
  it { expect have_attribute :reset_password_token }
  it { expect have_attribute :reset_password_sent_at }
  it { expect have_attribute :remember_created_at }

  describe "associations" do
    it { expect have_one :customer }
  end
end
