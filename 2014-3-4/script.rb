#!/usr/bin/env ruby
require 'mail'

mysql_username = 'root'
mysql_password = '123456'
mysql_database = 'test'
system("mysqldump --user=#{mysql_username} --password=#{mysql_password} #{mysql_database} > backup.sql")


# Credit to : 
# http://stackoverflow.com/questions/12884711/how-to-send-email-via-smtp-with-rubys-mail-gem
options = { 
	:address              => "smtp.gmail.com",
    :port                 => 587,
    :domain               => 'xxxxxxxxx@gmail.com',
    :user_name            => 'xxxxxxxxx@gmail.com',
    :password             => 'xxxxxxxxx',
    :authentication       => 'plain',
    :enable_starttls_auto => true  
}

Mail.defaults do
  delivery_method :smtp, options
end


Mail.deliver do
  from     options[:user_name]
  to       options[:user_name]
  subject  "Database #{mysql_database} backup #{Time.new}"
  body     "Database #{mysql_database} backup #{Time.new}"
  add_file 'backup.sql'
end

File.delete 'backup.sql'