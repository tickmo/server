require 'spec_helper'

describe ApplicationHelper, type: :helper do
  describe '#full_title' do
    let(:page_title) { 'Current Page' }
    let(:expected_title) { "Tickmo | #{page_title}" }
    let(:expected_root) { 'Tickmo' }

    it 'returns only application title' do
      expect(helper.full_title('')).to eql(expected_root)
    end

    it 'returns full title' do
      expect(helper.full_title(page_title)).to eql(expected_title)
    end
  end
end
