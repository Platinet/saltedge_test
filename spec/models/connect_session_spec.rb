
RSpec.describe ConnectSession, type: :model do
  it { expect have_attribute :customer_id }
  it { expect have_attribute :expires_at }
  it { expect have_attribute :connect_url }

  describe "scopes" do
    let(:active_connect) { create(:connect_session, expires_at: 1.day.after) }
    let(:inactive_connect) { create(:connect_session, expires_at: 1.day.ago) }

    describe ConnectSession, "#active" do
      it { expect(ConnectSession.active.include?(active_connect)).to be_truthy }
      it { expect(ConnectSession.active.include?(inactive_connect)).to be_falsey }
    end
  end
end