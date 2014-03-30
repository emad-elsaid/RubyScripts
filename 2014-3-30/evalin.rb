#!/usr/bin/env ruby
# Author : Emad Elsaid (https://github.com/blazeeboy)
require 'json'
require 'open-uri'
require 'uri'
require 'net/http'

CODE_LIMIT = 10
$url = "https://eval.in/"
$languages = {
	'c' => 'c/gcc-4.7.2',					'c++' => 'c++/gcc-4.7.2',
	'fortran' => 'fortran/f95-4.4.3',		'haskell' => 'haskell/hugs98-sep-2006',
	'io' => 'io/io-20110912',				'javascript' => 'javascript/node-0.10.26',
	'lua' => 'lua/lua-5.2.1',				'ocaml' => 'ocaml/ocaml-4.00.1',
	'php' => 'php/php-5.5.1',				'perl' => 'perl/perl-5.16.1',
	'python' => 'python/cpython-3.2.3',		'ruby' => 'ruby/mri-2.1.0',
	'slash' => 'slash/slash-head',			'assembly' => 'assembly/nasm-2.07'
}

def evalin code, language

	return nil unless $languages.keys.include? language
	return nil if code.length < CODE_LIMIT

	params = {
		code: code,			lang: $languages[language],
		execute: 'on',		input: ''
	}

	postData = Net::HTTP.post_form(URI.parse($url), params)
	location = postData['location']
	if location
		evalin_data = JSON.parse open("#{location.gsub 'http://', 'https://'}.json").read
		return "#{evalin_data['output']}\n#{evalin_data['status']}\n#{location}"
	end
	return nil
end

puts evalin('10.times{ puts "done."}', 'ruby')