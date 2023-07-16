# frozen_string_literal: true

require 'spec_helper'

describe 'timekpr::user' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) { facts }
        let(:title) { 'steve' }

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('timekpr') }
      end
    end
  end
end
