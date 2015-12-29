#! /usr/bin/env ruby

require 'pre-packager'

include PrePackager
file = 'release/mars/1/eclipse-jee-mars-1-linux-gtk-x86_64.tar.gz'
url = "http://eclipse.c3sl.ufpr.br/technology/epp/downloads/#{file}"
Application.new(name: '$basename-$version',
  basename: 'eclipse',
  version: 'mars',
  minor_version: '4.5.1').
  download_from url do |p|
    p.extract('/opt/$name', strip: 1) do |content|
      content.link '$name/eclipse', use_name: true
    end
  end.
  with_templates('templates/*', '/usr/local/share/applications').
  create_package(dry_run: false,
                  version: '$minor_version',
                  description: 'Eclipse JEE $version',
                  maintainer: 'Gonzalo Matheu <gonzalommj@gmail.com>')

