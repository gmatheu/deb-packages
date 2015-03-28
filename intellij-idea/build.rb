#! /usr/bin/env ruby

require 'optparse'
require 'pre-packager'

include PrePackager

options={major: '14',
         minor: '1'}
OptionParser.new do |opts|
  opts.banner = "Usage: #{$0} [--major 14] [--minor 0.3]"
  opts.on('--major major', 'Major Version') do |major|
    options[:major] = major.to_s
  end

  opts.on('--minor minor', 'Minor Version') do |minor|
    options[:minor] = minor.to_s
  end

  opts.on('-h', '--help', 'Displays Help') do
    puts opts
    exit
  end
end.parse!

Application.new(name: 'ideaIC-$version',
                version: options[:major],
                minor_version: options[:minor]).
download_from 'http://download-cf.jetbrains.com/idea/$name.$minor_version.tar.gz' do |p|
                  p.extract('/opt', strip: 1, use_name: true) do |content|
                    content.link 'bin/idea.sh', use_name: true
                  end
                end.
                with_templates('template/usr/local/share/applications/*', '/usr/local/share/applications').
                with_templates('template/idea.properties', '/opt/$name/bin').
                create_package(dry_run: false,
                               version: '$version.$minor_version',
                               description: 'IntelliJ Idea $version Community Edition',
                               maintainer: 'Gonzalo Matheu <gonzalommj@gmail.com>')

