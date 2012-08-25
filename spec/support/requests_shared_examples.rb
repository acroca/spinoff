shared_examples_for "an authenticated request" do
  its(:status) { should_not == 401 }

  context 'without a valid user' do
    let(:user) { nil }
    its(:status) { should == 401 }
  end
end

shared_examples_for "a request that validates the company" do
  its(:status) { should_not == 406 }

  context 'without a company' do
    before { user.company = nil }
    its(:status) { should == 406 }
  end
end
