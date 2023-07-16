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

        it {
          is_expected.to contain_file('/var/lib/timekpr/conf/timekpr.steve.conf').
            with_content(%r{^ALLOWED_HOURS_1 = $}).
            with_content(%r{^ALLOWED_HOURS_7 = $})
        }

        context 'with a day set' do
          let(:params) do
            {
              days: {
                monday:  { '3': [0, 45] },
                tuesday: {
                  '3': [0, 41],
                  '21': [10, 49],
                }
              },
            }
          end

          it {
            is_expected.to contain_file('/var/lib/timekpr/conf/timekpr.steve.conf').
              with_content(%r{^ALLOWED_HOURS_1 = 3\[0-45\]$}).
              with_content(%r{^ALLOWED_HOURS_2 = 3\[0-41\];21\[10-49\]$}).
              with_content(%r{^ALLOWED_HOURS_7 = $})
          }
        end

        context 'with a default set' do
          let(:params) do
            {
              defaults: {
                '3': [0, 45],
                '6': [0, 41],
              },
            }
          end

          it {
            is_expected.to contain_file('/var/lib/timekpr/conf/timekpr.steve.conf').
              with_content(%r{^ALLOWED_HOURS_1 = 3\[0-45\];6\[0-41\]$}).
              with_content(%r{^ALLOWED_HOURS_2 = 3\[0-45\];6\[0-41\]$}).
              with_content(%r{^ALLOWED_HOURS_7 = 3\[0-45\];6\[0-41\]$})
          }
        end

        context 'with a default and day values set' do
          let(:params) do
            {
              defaults: {
                '3': [0, 45],
                '6': [0, 41],
              },
              days: {
                monday:  { '6': [0, 41] },
                tuesday: {
                  '3': [0, 51],
                  '21': [10, 49],
                }
              },

            }
          end

          it {
            is_expected.to contain_file('/var/lib/timekpr/conf/timekpr.steve.conf').
              with_content(%r{^ALLOWED_HOURS_1 = 3\[0-45\];6\[0-41\]$}).
              with_content(%r{^ALLOWED_HOURS_2 = 3\[0-51\];6\[0-41\];21\[10-49]$}).
              with_content(%r{^ALLOWED_HOURS_7 = 3\[0-45\];6\[0-41\]$})
          }
        end
      end
    end
  end
end
