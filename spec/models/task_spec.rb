RSpec.describe Task, type: :model do
  it { is_expected.to belong_to(:project) }
  it { is_expected.to have_many(:comments) }
end
