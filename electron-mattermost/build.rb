#! /usr/bin/env ruby

require 'optparse'
require 'pre-packager'

include PrePackager

options={version: '1.0.1'}
OptionParser.new do |opts|
  opts.banner = "Usage: #{$0} [--version 1.0.0 ]"

  opts.on('--version version', 'One of the versions from: https://github.com/yuya-oc/electron-mattermost/releases') do |version|
    options[:version] = version.to_s
  end

  opts.on('-h', '--help', 'Displays Help') do
    puts opts
    exit
  end
end.parse!

p
Application.new(name: 'electron-mattermost',
                version: options[:version], minor_version: '0').
download_from "https://github.com/yuya-oc/electron-mattermost/releases/download/v$version/electron-mattermost-v$version-linux-x64.tar.gz" do |p|
                  p.extract('/opt', strip: 1, use_name: true) do |content|
                    content.link 'electron-mattermost', use_name: true
                  end
                end.
                with_templates('template/usr/local/share/applications/*', '/usr/local/share/applications').
                create_package(dry_run: false,
                               version: '$version',
                               description: 'Electron-based desktop application for Mattermost (https://github.com/yuya-oc/electron-mattermost)',
                               maintainer: 'Gonzalo Matheu <gonzalommj@gmail.com>')

