
RSpec.describe Transaction, type: :model do
  it { expect have_attribute :account_id }
  it { expect have_attribute :duplicated }
  it { expect have_attribute :mode }
  it { expect have_attribute :status }
  it { expect have_attribute :made_on }
  it { expect have_attribute :amount }
  it { expect have_attribute :currency_code }
  it { expect have_attribute :description }
  it { expect have_attribute :category }
  it { expect have_attribute :extra }
end