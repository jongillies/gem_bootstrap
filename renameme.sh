#!/bin/bash

die () {
    echo >&2 "$@"
    exit 1
}

name=`basename $PWD`

if [ "$name" == "gem_bootstrap" ]
then
  echo "You must rename the parent directory to a real gem name, not leave it as gem_bootstrap"
  exit 1
fi

has_extlib=`gem list | grep "extlib "`

if [ "$has_extlib" == "" ]
then
  gem install extlib
  if [ $? -ne 0 ]
  then
    echo "Some problem installing extlib, can't continue..."
    exit 1
  fi
fi

module_name=`ruby -e "require 'extlib/string';  puts \"$name\".camel_case"`

files="Gemfile
Gemfile.lock
README.md
gem_bootstrap.gemspec
lib/gem_bootstrap.rb
lib/gem_bootstrap/version.rb
spec/cli_spec.rb
bin/gem_bootstrap.rb"

for file in $files
do
  sed -i.bak "s/gem_bootstrap/${name}/g" $file
done

files="gem_bootstrap.gemspec
README.md
lib/gem_bootstrap.rb
lib/gem_bootstrap/version.rb
spec/cli_spec.rb
bin/gem_bootstrap.rb"

for file in $files
do
  sed -i.bak "s/GemBootstrap/${module_name}/g" $file
done

mv gem_bootstrap.gemspec $name.gemspec
mv lib/gem_bootstrap lib/$name
mv lib/gem_bootstrap.rb lib/$name.rb
mv bin/gem_bootstrap.rb bin/$name.rb
rm bin/gem_bootstrap
cd bin
ln -s $name.rb $name

echo "rvm use ruby-1.9.3-p484@$name --create" > .rvmrc

find . | grep \.bak$ | xargs rm

rm -rfi .git

