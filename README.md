#rbnotify-weechat

A simple notification script for [weechat](http://weechat.org) that uses notify-send. By default it will send a notification on highlights and private
messages.

## Installation

```shell
cd ~/.weechat/ruby
wget https://raw.githubusercontent.com/gregf/rbnotify-weechat/master/rbnotify-weechat.rb
cd ~/.weechat/ruby/autoload
ln -s ../rbnotify-weechat.rb .
```

Now start weechat. If weechat is already running typing, `/ruby reload` in your weechat buffer should do the trick.

## Options

by default private messages and highlights are turned on. You can adjust these like so.

```
/set plugins.var.ruby.rbnotify-weechat.show_highlights = off
/set plugins.var.ruby.rbnotify-weechat.show_private_messages = off
```
