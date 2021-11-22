RSpec.describe User, type: :model do
  it { is_expected.to have_many(:projects).dependent(:destroy) }
  it { is_expected.to have_many(:tasks).through(:projects) }
  it { is_expected.to have_many(:comments).through(:tasks) }
  it { is_expected.to validate_presence_of(:email) }
end
