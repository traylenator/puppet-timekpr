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
          is_expected.to contain_file('/var/lib/timekpr/config/timekpr.steve.conf').
          with_content(%r{^ALLOWED_HOURS_1 = 0\[0-59\];1\[0-59\];2\[0-59\];3\[0-59\];4\[0-59\];5\[0-59\];6\[0-59\];7\[0-59\];8\[0-59\];9\[0-59\];10\[0-59\];11\[0-59\];13\[0-59\];15\[0-59\];16\[0-59\];17\[0-59\];18\[0-59\];19\[0-59\];20\[0-59\];21\[0-59\];23\[0-59\]$}).
            with_content(%r{^ALLOWED_HOURS_7 = 0\[0-59\];1\[0-59\];2\[0-59\];3\[0-59\];4\[0-59\];5\[0-59\];6\[0-59\];7\[0-59\];8\[0-59\];9\[0-59\];10\[0-59\];11\[0-59\];13\[0-59\];15\[0-59\];16\[0-59\];17\[0-59\];18\[0-59\];19\[0-59\];20\[0-59\];21\[0-59\];23\[0-59\]$})
        }

        context 'with a day set' do
          let(:params) do
            {
              default_hours: {},
              day_hours: {
                monday:  { '3': [0, 45] },
                tuesday: {
                  '3': [0, 41],
                  '21': [10, 49],
                }
              },
            }
          end

          it {
            is_expected.to contain_file('/var/lib/timekpr/config/timekpr.steve.conf').
              with_content(%r{^ALLOWED_HOURS_1 = 3\[0-45\]$}).
              with_content(%r{^ALLOWED_HOURS_2 = 3\[0-41\];21\[10-49\]$}).
              with_content(%r{^ALLOWED_HOURS_7 = $})
          }
        end

        context 'with a default set' do
          let(:params) do
            {
              default_hours: {
                '3': [0, 45],
                '6': [0, 41],
              },
            }
          end

          it {
            is_expected.to contain_file('/var/lib/timekpr/config/timekpr.steve.conf').
              with_content(%r{^ALLOWED_HOURS_1 = 3\[0-45\];6\[0-41\]$}).
              with_content(%r{^ALLOWED_HOURS_2 = 3\[0-45\];6\[0-41\]$}).
              with_content(%r{^ALLOWED_HOURS_7 = 3\[0-45\];6\[0-41\]$})
          }
        end

        context 'with a default and day values set' do
          let(:params) do
            {
              default_hours: {
                '3': [0, 45],
                '6': [0, 41],
              },
              day_hours: {
                monday:  { '6': [0, 41] },
                tuesday: {
                  '3': [0, 51],
                  '21': [10, 49],
                }
              },

            }
          end

          it {
            is_expected.to contain_file('/var/lib/timekpr/config/timekpr.steve.conf').
              with_content(%r{^ALLOWED_HOURS_1 = 3\[0-45\];6\[0-41\]$}).
              with_content(%r{^ALLOWED_HOURS_2 = 3\[0-51\];6\[0-41\];21\[10-49\]$}).
              with_content(%r{^ALLOWED_HOURS_7 = 3\[0-45\];6\[0-41\]$})
          }
        end
      end
    end
  end
end
