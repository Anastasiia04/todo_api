RSpec.describe Comment, type: :model do
  it { is_expected.to belong_to(:task) }
  it { is_expected.to validate_presence_of(:name) }
end
