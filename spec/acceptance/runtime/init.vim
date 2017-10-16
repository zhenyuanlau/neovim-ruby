let s:lib_path = getcwd() . "/../../lib/"
let s:bin_path = getcwd() . "/../../bin/neovim-ruby-host"
let g:ruby_host_prog = printf("ruby -I %s %s", s:lib_path, s:bin_path)

set rtp=./runtime,./runtime/vader.vim,$VIMRUNTIME

ruby << EOS
require "rspec"

if ENV["REPORT_COVERAGE"]
  require "coveralls"
  Coveralls.wear_merged!
  SimpleCov.merge_timeout 3600
  SimpleCov.command_name "spec:acceptance:#{Process.pid}"
end

$:.unshift File.expand_path("../../../lib", __FILE__)
require "neovim"
EOS

function! RunSuite() abort
  ruby $output = ENV["RSPEC_OUTPUT_FILE"]
  ruby $result = RSpec::Core::Runner.run([], $output, $output)
  ruby Vim.command($result == 0 ? "qa!" : "cq!")
endfunction