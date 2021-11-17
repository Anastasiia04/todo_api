RSpec.describe Project, type: :model do
  it { is_expected.to have_many(:tasks) }
end
