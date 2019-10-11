require 'rails_helper'

RSpec.describe Log, type: :model do
  context "structure" do
    it { should have_db_column(:year) }
    it { should have_db_column(:population) }
    it { should have_db_index(:year) }
  end

  context "validations" do
    it { should validate_presence_of(:year) }
    it { should validate_presence_of(:population) }
  end

end
