
RSpec.describe Account, type: :model do
  it { expect have_attribute :connection_id }
  it { expect have_attribute :remote_id }
  it { expect have_attribute :name }
  it { expect have_attribute :nature }
  it { expect have_attribute :balance }
  it { expect have_attribute :currency_code }
  it { expect have_attribute :extra }

  describe "associations" do
    it { expect have_many :transaction }
  end
end