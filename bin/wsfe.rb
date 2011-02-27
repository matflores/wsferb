#!/usr/bin/env ruby

require 'pathname'

bin = File.dirname(Pathname.new(__FILE__).realpath)
src = File.expand_path(File.join(bin, '..', 'src'))
lib = File.join(src, 'lib')

$:.unshift(src)
$:.unshift(lib)

load 'init.rb'
