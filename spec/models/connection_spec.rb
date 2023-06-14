
RSpec.describe Connection, type: :model do
  it { expect have_attribute :customer_id }
  it { expect have_attribute :remote_id }
  it { expect have_attribute :response }
  it { expect have_attribute :country_code }
  it { expect have_attribute :last_success_at }
  it { expect have_attribute :next_refresh_possible_at }
  it { expect have_attribute :provider_id }
  it { expect have_attribute :provider_code }
  it { expect have_attribute :provider_name }
  it { expect have_attribute :status }
  it { expect have_attribute :removed }

  describe "associations" do
    it { expect have_many :accounts }
  end
end