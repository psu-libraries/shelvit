# frozen_string_literal: true

RSpec.describe Shelvit do
  subject { described_class.normalize(call_number) }

  context 'with a type LC number' do
    let(:call_number) { 'AB123 .C456 2000' }

    it { is_expected.to eq('AB.0123.C456.2000') }
  end

  context 'with a number that Lcsort cannot process' do
    let(:call_number) { 'Fiction G758thefu 2015' }

    it { is_expected.to be_nil }
  end

  context 'with lower-case letters in the middle of a cutter' do
    let(:call_number) { 'LD4481.P8kG45 2008' }

    it { is_expected.to eq('LD.4481.P810.G45--2008') }
  end

  context 'with lower-case letters at the end of a cutter' do
    let(:call_number) { 'PZ7.H56774Fou 2014' }

    it { is_expected.to eq('PZ.0007.H56774.F1420--2014') }
  end

  context 'with colons in a cutter' do
    let(:call_number) { 'G3824.S8:2P4E635 2017 .P4' }

    it { is_expected.to eq('G..3824.S8.0002.P4.E635--2017P0004') }
  end

  context 'with three-letter LC classifications' do
    let(:call_number) { 'KJD.In8i' }

    it { is_expected.to eq('KJD0000.I13808') }
  end
end
