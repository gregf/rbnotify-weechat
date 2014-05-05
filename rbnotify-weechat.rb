#!/usr/bin/env ruby

SCRIPT_NAME = 'rbnotify-weechat'
SCRIPT_AUTHOR = 'Greg Fitzgerald <greg@gregf.org>'
SCRIPT_DESC = 'Sends libnotify notifications upon events.'
SCRIPT_VERSION = '0.2'
SCRIPT_LICENSE = 'MIT'

DEFAULTS = {
  'show_private_message' => 'on',
  'show_highlight' => 'on'
}


def weechat_init
  Weechat.register SCRIPT_NAME, SCRIPT_AUTHOR, SCRIPT_VERSION, SCRIPT_LICENSE, SCRIPT_DESC, "", ""
  DEFAULTS.each_pair { |option, def_value|
    cur_value = Weechat.config_get_plugin(option)
    if cur_value.nil? || cur_value.empty?
      Weechat.config_set_plugin(option, def_value)
    end
  }

  hook_notifications

  return Weechat::WEECHAT_RC_OK
end

def hook_notifications
  Weechat.hook_signal("weechat_pv", "show_private", "")
  Weechat.hook_signal("weechat_highlight", "show_highlight", "")
end

def unhook_notifications(data, signal, message)
  Weechat.unhook(show_private)
  Weechat.unhook(show_highlight)
end

def show_private(data, signal, message)
  if Weechat.config_get_plugin('show_private_message') == 'on'
    message[0..1] == '--' ? sticky = false : sticky = true
    show_notification("Private", "Weechat Private Message",  message, sticky)
    return Weechat::WEECHAT_RC_OK
  end
end

def show_highlight(data, signal, message)
 if Weechat.config_get_plugin('show_highlight') == 'on'
    message[0..1] == '--' ? sticky = false : sticky = true
    show_notification("Highlight", "Weechat",  message, sticky)
    return Weechat::WEECHAT_RC_OK
  end
end

def show_notification(name, title, message, sticky = true)
  if sticky
    system("/usr/bin/notify-send -u critical '#{name} ' '#{message}'")
  else
    system("/usr/bin/notify-send -u low '#{name} ' '#{message}'")
  end
end

__END__
__LICENSE__

Copyright (c) 2014 Greg Fitzgerald <greg@gregf.org>

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
