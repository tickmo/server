require 'spec_helper'

describe ApplicationPolicy do
  subject { ApplicationPolicy.new(user) }

  describe 'for a user' do
    let(:user) { FactoryGirl.create(:user) }

    it { should_not permit(:index)   }
    it { should_not permit(:show)    }
    it { should_not permit(:create)  }
    it { should_not permit(:update)  }
    it { should_not permit(:destroy) }
  end
end
