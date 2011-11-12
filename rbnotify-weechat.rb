begin
  require 'libnotify'
rescue
  require 'rubygems'
  require 'libnotify'
end

SCRIPT_NAME = 'rbnotify-weechat'
SCRIPT_AUTHOR = 'Greg Fitzgerald <netzdamon@gmail.com'
SCRIPT_DESC = 'Sends libnotify notifications upon events.'
SCRIPT_VERSION = '0.1'
SCRIPT_LICENSE = 'MIT'

def weechat_init
  Weechat.register SCRIPT_NAME, SCRIPT_AUTHOR, SCRIPT_VERSION, SCRIPT_LICENSE, SCRIPT_DESC, "", ""

  Weechat.hook_signal("weechat_highlight", "notify", "")
  Weechat.hook_signal("weechat_pv", "notify", "")

  return Weechat::WEECHAT_RC_OK
end

def notify(data, signal, signal_data)

  if signal == "weechat_pv"
    event = "Private message"
  elsif signal == "weechat_highlight"
    event = "Highlight"
  end

  n = Libnotify.new do |notify|
    notify.summary    = event
    notify.body       = signal_data
    notify.timeout    = 8      # 1.5 (s), 1000 (ms), "2", nil, false
    notify.urgency    = :low   # :low, :normal, :critical
    notify.append     = true   # default true - append onto existing notification
    notify.transient  = true   # default false - keep the notifications around after display
    notify.icon_path  = "icon.png"
   end
   n.show!

  return Weechat::WEECHAT_RC_OK
end

__END__
__LICENSE__

Copyright (c) 2011 Greg Fitzgerald <netzdamon@gmail.com>

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

