#!/usr/bin/env ruby
# Author : Emad Elsaid (https://github.com/blazeeboy)
require "selenium-webdriver" # gem install selenium-webdriver
require "highline/import" # gem install highline

def coderwall github_email, github_password, title, content, tags

	driver = Selenium::WebDriver.for :firefox

	driver.navigate.to "https://coderwall.com/auth/github"
	
	driver.find_element(:css, '#login_field').send_keys github_email
	passwordf = driver.find_element(:css, '#password')
	passwordf.send_keys github_password
	passwordf.submit

	driver.navigate.to "https://coderwall.com/p/new"
	driver.find_element(:css, '#protip_title').send_keys title
	driver.find_element(:css, '#protip_body').send_keys content
	driver.find_element(:css, '#protip_tags').send_keys tags
	driver.find_element(:css, '.new_protip').submit

	driver.quit
end

email = ask 'What is your github email address ? '
password = ask('And github password? '){ |q| q.echo = '*' }
coderwall email, password, 'Title here', 'Content here', 'ruby, test'