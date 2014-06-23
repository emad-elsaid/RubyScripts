#!/usr/bin/env ruby
# Author : Emad Elsaid (https://github.com/blazeeboy)

require 'gtk2' # gem install gtk2

# lets define some constants we need
WORKING_HOURS = 8 # hours
WORKING_SECONDS = WORKING_HOURS * 60 * 60
ALERT = "Your working hours have been ended,\n go out and enjoy your life."

# we'll inherit the Gtk window
# and make our custom behaviour inside it
class WorkEndWindow < Gtk::Window

  # set some window properties
  # and insert a label with the desired text
  # then link the window destroy event with a
  # method to exit the application
  def initialize
    super

    self.title = ':D'
    self.border_width = 20
    self.window_position = Gtk::Window::POS_CENTER_ALWAYS

    add Gtk::Label.new ALERT
    signal_connect("destroy") { Gtk.main_quit }
    show_all
  end
end

# this will wait for you to finish work and 
# then pops up the amazing window that will
# tell you to go home ^_^ 
# it will create a window then start 
# the Gtk main loop
sleep WORKING_SECONDS
WorkEndWindow.new
Gtk.main