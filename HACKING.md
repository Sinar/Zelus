Hacker's Guide to Zelus
=======================

Quick Start
-----------

    gem install bundler
    bundle install
    bundle exec irb -r ./migrations.rb
      DataMapper.auto_upgrade!
      Setup.migrate
    ^D
    bundle exec thin start

Quick Test
----------

    DATABASE_URL="mysql://u:p@h/zelus_test" bundle exec rspec -f d

Problems
--------

### Can't install some gems on Windows ###

Sometimes, `gem install` can do a better job. Here're solution links to troublesome gems:

 - [pg](http://stackoverflow.com/a/9244988/36397)
 - [thin](http://stackoverflow.com/a/4200880/36397)

