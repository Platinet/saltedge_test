
RSpec.describe Customer, type: :model do
  it { expect have_attribute :user_id }
  it { expect have_attribute :remote_id }
  it { expect have_attribute :identifier }
  it { expect have_attribute :secret }
  it { expect have_attribute :blocked_at }

  describe "associations" do
    it { expect have_many :connection }
    it { expect have_many :connect_session }
  end
end
