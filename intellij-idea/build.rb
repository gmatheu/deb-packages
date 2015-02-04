#! /usr/bin/env ruby

require 'pre-packager'

include PrePackager
Application.new(name: 'ideaIC-$version',
  version: '14',
  minor_version: '0.3').
    download_from 'http://download-cf.jetbrains.com/idea/$name.$minor_version.tar.gz' do |p|
    p.extract('/opt', strip: 1, use_name: true) do |content|
      content.link 'bin/idea.sh', use_name: true
    end
  end.
  with_templates('template/usr/local/share/applications/*', '/usr/local/share/applications').
  create_package(dry_run: false,
                  version: '$version.$minor_version',
                  description: 'IntelliJ Idea $version Community Edition',
                  maintainer: 'Gonzalo Matheu <gonzalommj@gmail.com>')

