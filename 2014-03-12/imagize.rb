#!/usr/bin/env ruby
require 'pygmentize' # gem install pygmentize
require 'selenium-webdriver' # gem install selenium-webdriver

exit unless code_path = ARGV.shift

file_path = File.absolute_path 'code.html'
image_path = File.absolute_path 'code_image.png'
code = Pygmentize.process File.read(code_path), :ruby
html = <<-EOT
<html>
<style>
body { padding:0px; margin:0px; } .highlight { padding: 20px; font-size: 13px; }div.highlight, div.highlight code, div.highlight pre  { background: #29281e; }div.highlight code { padding: 0; }div.highlight .c { color: #75715e }div.highlight .err { color: #960050; background-color: #1e0010 }div.highlight .k { color: #66d9ef }div.highlight .l { color: #ae81ff }div.highlight .n { color: #f8f8f2 }div.highlight .o { color: #f92672 }div.highlight .p { color: #f8f8f2 }div.highlight .cm { color: #75715e }div.highlight .cp { color: #75715e }div.highlight .c1 { color: #75715e }div.highlight .cs { color: #75715e }div.highlight .ge { font-style: italic }div.highlight .gs { font-weight: bold }div.highlight .kc { color: #66d9ef }div.highlight .kd { color: #66d9ef }div.highlight .kn { color: #f92672 }div.highlight .kp { color: #66d9ef }div.highlight .kr { color: #66d9ef }div.highlight .kt { color: #66d9ef }div.highlight .ld { color: #e6db74 }div.highlight .m { color: #ae81ff }div.highlight .s { color: #e6db74 }div.highlight .na { color: #a6e22e }div.highlight .nb { color: #f8f8f2 }div.highlight .nc { color: #a6e22e }div.highlight .no { color: #66d9ef }div.highlight .nd { color: #a6e22e }div.highlight .ni { color: #f8f8f2 }div.highlight .ne { color: #a6e22e }div.highlight .nf { color: #a6e22e }div.highlight .nl { color: #f8f8f2 }div.highlight .nn { color: #f8f8f2 }div.highlight .nx { color: #a6e22e }div.highlight .py { color: #f8f8f2 }div.highlight .nt { color: #f92672 }div.highlight .nv { color: #f8f8f2 }div.highlight .ow { color: #f92672 }div.highlight .w { color: #f8f8f2 }div.highlight .mf { color: #ae81ff }div.highlight .mh { color: #ae81ff }div.highlight .mi { color: #ae81ff }div.highlight .mo { color: #ae81ff }div.highlight .sb { color: #e6db74 }div.highlight .sc { color: #e6db74 }div.highlight .sd { color: #e6db74 }div.highlight .s2 { color: #e6db74 }div.highlight .se { color: #ae81ff }div.highlight .sh { color: #e6db74 }div.highlight .si { color: #e6db74 }div.highlight .sx { color: #e6db74 }div.highlight .sr { color: #e6db74 }div.highlight .s1 { color: #e6db74 }div.highlight .ss { color: #e6db74 }div.highlight .bp { color: #f8f8f2 }div.highlight .vc { color: #f8f8f2 }div.highlight .vg { color: #f8f8f2 }div.highlight .vi { color: #f8f8f2 }div.highlight .il { color: #ae81ff }</style>
</style>
<body>#{code}</body>
</html>
EOT

File.open( file_path, 'w' ) do |file|
	file.write html
end

driver = Selenium::WebDriver.for :firefox
driver.navigate.to "file://#{file_path}"
driver.save_screenshot(image_path)
driver.close

File.delete file_path

# usage imagize.rb /path/to/code/file.rb
#result is similar to :
# http://imgur.com/HYknU7c