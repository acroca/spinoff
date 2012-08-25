shared_examples_for "a program subclass" do
  it { should allow_value('How I met your mother').for(:name) }
  it { should_not allow_value('   ').for(:name) }
  it { should_not allow_value('').for(:name) }
  it { should_not allow_value(nil).for(:name) }

  context "a program exists" do
    before { described_class.create name: "Some name" }
    it { should_not allow_value('Some name').for(:name) }
  end

  it { should allow_value(true).for(:available) }
  it { should allow_value(false).for(:available) }
  it { should_not allow_value(nil).for(:available) }

  its(:available) { should be_false }

  it { should be_a_kind_of(described_class) }
  it { should be_a_kind_of(Program) }

  describe ".available scope" do
    let!(:available) { create(described_class.to_s.underscore.to_sym, available: true) }
    let!(:not_available) { create(described_class.to_s.underscore.to_sym) }

    subject { described_class.available }

    it { should include available }
    it { should_not include not_available }
  end

  describe ".generate" do
    subject { described_class.generate }

    it { should be_kind_of(described_class) }

    it { should be_available }

    it 'creates a new program' do
      expect {
        subject
      }.to change(Program, :count).by(1)
    end

    it 'has a random name' do
      described_class.should_receive(:random_name).and_return("Random")
      subject.name.should == "Random"
    end
  end

  describe ".as_json" do
    let(:object) { create(described_class.to_s.underscore.to_sym) }
    subject { object.as_json }
    it { should == {id: object.to_param, name: object.name} }
  end
end
