require 'spec_helper'
require 'gem_bootstrap'
require 'shellwords'
require 'yaml'

describe 'Different Command Line Options' do

  it 'should fail with no options' do
    expect { GemBootstrap::GemName.new({}) }.to raise_error
  end

  it 'should succeed with minimum arguments' do
    args = 'my-argument'
    expect { GemBootstrap::GemName.new(args.shellsplit) }.not_to raise_error
  end

  it 'should spit out help' do
    args = '--help'
    expect { GemBootstrap::GemName.new(args.shellsplit) }.to raise_error
  end

  it 'should spit out version' do
    args = '--version'
    expect { GemBootstrap::GemName.new(args.shellsplit) }.to raise_error
  end

end

