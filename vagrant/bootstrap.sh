#!/usr/bin/env bash

readonly VAGRANT_HOME=/home/vagrant

# apt-get update
apt-get install -y vim git
if ! [ -L /var/www ]; then
  rm -rf /var/www
  ln -fs /vagrant /var/www
fi

# Avoid installing gems docs.
if ! [ -f $VAGRANT_HOME/.gemrc ]; then
  touch $VAGRANT_HOME/.gemrc
  echo 'install: --no-rdoc --no-ri' >> $VAGRANT_HOME/.gemrc
  echo  'update: --no-rdoc --no-ri' >> $VAGRANT_HOME/.gemrc
fi

echo 'deb http://ftp.us.debian.org/debian/ wheezy-backports main' >> /etc/apt/sources.list
echo 'deb-src http://ftp.us.debian.org/debian/ wheezy-backports main' >> /etc/apt/sources.list

apt-get update -y
apt-get install -y build-essential libssl-dev libcurl4-openssl-dev libreadline-dev bundler

# Install rbenv.
sudo -H -u vagrant git clone https://github.com/sstephenson/rbenv.git $VAGRANT_HOME/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> $VAGRANT_HOME/.bashrc
echo 'eval "$(rbenv init -)"' >> $VAGRANT_HOME/.bashrc
sudo -H -u vagrant git clone https://github.com/sstephenson/ruby-build.git $VAGRANT_HOME/.rbenv/plugins/ruby-build
sudo -H -u vagrant git clone https://github.com/sstephenson/rbenv-gem-rehash.git $VAGRANT_HOME/.rbenv/plugins/rbenv-gem-rehash

# Install ruby.
sudo -H -u vagrant bash -i -c 'rbenv install 2.0.0-p576'
sudo -H -u vagrant bash -i -c 'rbenv global  2.0.0-p576'
sudo -H -u vagrant bash -i -c 'rbenv rehash'

# Set up rails.
sudo apt-get install -y sqlite3 libsqlite3-dev
sudo apt-get -y -t wheezy-backports install nodejs

# Set up project.
cd /vagrant/
sudo -H -u vagrant bash -i -c 'gem install bundle'
sudo -H -u vagrant bash -i -c 'bundle install'
