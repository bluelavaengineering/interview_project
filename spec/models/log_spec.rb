require 'rails_helper'

RSpec.describe Log, type: :model do
  context "structure" do
    it { should have_db_column(:year) }
    it { should have_db_column(:population) }
    it { should have_db_column(:request_type) }

    it { should have_db_index(:year) }
    it { should have_db_index(:request_type) }
  end

  context "validations" do
    it { should validate_presence_of(:year) }
    it { should validate_presence_of(:population) }
    it { should validate_presence_of(:request_type) }
  end

  context "activemodel" do
    it { should define_enum_for(:request_type) }
  end

  context "use" do
    let(:line) { FactoryBot.create(:log) }

    it "should have a single record" do
      pp "line: #{line.inspect}"
      expect(Log.all.count).to eq 1
    end
  end

end
