require 'spec_helper'

describe UserPolicy do
  subject { UserPolicy.new(user) }

  describe 'for a user' do
    let(:user) { FactoryGirl.create(:user) }

    it { should permit(:show)    }
    it { should permit(:create)  }
    it { should permit(:update)  }
    it { should permit(:destroy) }
  end
end
