---
layout: post
current: post
navigation: True
class: post-template
subclass: 'post'
author: brig
title: "Getting Started with Ruby on Rail in Eclipse"
date: "2010-12-15"
---

I want to run a test app in ROR. Of course I want this to work in Eclipse so I looked around to see how to do it. After reading a few things and making a few mistakes, here is how I did it.

## First Install Ruby

- Install [Eclipse DLTK Plug-in](http://download.eclipse.org/technology/dltk/updates/). Select just the core and the ruby items
- Install Ruby Interpreter
```bash
sudo apt-get install ruby-full
```
- Point Eclipse to Ruby. Window -> Preferences -> Ruby -> Interpreters. `/usr/lib/ruby`
- Test
    - Create new Ruby Project
    - Create new Ruby Script File
    ```ruby
    puts "Hello there!"
    ```
    - Run as Ruby Script
- Install Rubygem
    ```ruby
    wget http://production.cf.rubygems.org/rubygems/rubygems-1.3.7.tgz
    tar zxvf rubygems-1.3.7.tgz
    cd rubygems-1.3.7
    ruby setup.rb
    ln -s /usr/bin/gem1.8 /usr/local/bin/gem
    ```

## Install SQLite and Rails

```bash
# Install SQLite
sudo apt-get install sqlite3 libsqlite3-dev
sudo gem install sqlite3-ruby

# Now Rails
gem install rails
```

## Configure Eclipse to Create Rails Projects

- Select Run -> External Tools -> External Tools
- Select "Program" from the configuration tree
- Select **New** to create a new program
- Enter "Create Rails Application in Project" as the name
- Enter **/usr/bin/rails** for the Location
- Enter **${project_loc}** for the Working Directory
- Enter **new ../ ${project_name}** for the Arguments
- Select the refresh tab and check Refresh Resources Upon Completion
- Select the **Common** tab
    - Find the section for **Display in Favorites Menu**
    - Check the box next to **External Tools**
    - Select **Apply**

## Notes

I installed both mysql and sqlite3. Although I think I already had mysql on the machine.

## Resources

- [Rails Guide](http://guides.rubyonrails.org/getting_started.html)
- [Rails on Ubuntu](http://castilho.biz/blog/2010/05/08/how-to-install-ruby-on-rails-on-ubuntu-10-04-lucid-lynx/)
- [Ruby Development Tools (RDT) plug-in for Eclipse](http://www.ibm.com/developerworks/opensource/library/os-eclipse-rdt/)
- [Install Ruby in Eclipse](http://www.eclipse.org/forums/index.php?t=msg&goto=640363&S=da2aad89cec94e7200cb29abd62efcbc)
- [Ruby Downloads](http://www.ruby-lang.org/en/downloads/)
- [Sqlite3 on Ubuntu](http://theplana.wordpress.com/2007/05/11/install-sqlite3-on-ubuntu/)
- [Configure Eclipse for Rails](http://napcs.com/howto/railsonwindows.html#_Toc111133461)
