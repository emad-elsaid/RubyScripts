# Convert Ruby scripts to HTML and Markdown


```ruby
#!/usr/bin/env ruby

```
Author : Emad Elsaid (https://github.com/blazeeboy)
```ruby
require 'pygmentize' # gem install pygmentize
require 'redcarpet' # gem install redcarpet


```
consecutive lines of code
should be highlighted using pygmentize
and converter to markdown block simply
using the markdown syntax for code
used by github flavored markdown
```ruby
class CodeBlock < Array

  def to_html
    Pygmentize.process join, :ruby
  end

  def to_md
    "```ruby\n#{join}\n```"
  end
  alias_method :to_markdown, :to_md
end


```
set of consecutive lines of comments
```ruby
class CommentBlock < Array


```
will use this Redcarpet renderer to convert
markdown to html
```ruby
  @@renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML, 
                            fenced_code_blocks: true,
                            disable_indented_code_blocks: true,
                            strikethrough: true,
                            superscript: true,
                            underline: true,
                            autolink: true )


```
use the renderer on the content
```ruby
  def to_html
    @@renderer.render join("\n")
  end


```
convert the block to markdown format
and also give it a full name alias
```ruby
  def to_md
    join("\n")
  end
  alias_method :to_markdown, :to_md

end 


```
container class will have multiple blocks of
comments and code
```ruby
class CodeConverter < Array


```
you should pass code when
initializing new instance
in order to parse it
```ruby
  def initialize( code )
    parse code
  end


```
add new line of code to the class
it start new code block if the last block is
not code block then adds the line of code
to the last block
```ruby
  def add_code( line )
    self << CodeBlock.new unless last.is_a? CodeBlock
    last << line
  end


```
add new comment line to the class
it adds new comment block if the last block is not
comments block then add the comment line to the block
```ruby
  def add_comment( line )
    self << CommentBlock.new unless last.is_a? CommentBlock
    last << line
  end


```
parse code and put result to this class
first insert a comment block then
parse each line and add it according
to the line type
```ruby
  def parse(code)
    replace [CommentBlock.new]

    code.lines.each do |line|
      case
        when line.strip.start_with?('# ')
          add_comment line.strip[2..-1]

        when line.strip.start_with?('#!')
          add_code line

        when line.strip.start_with?('#')
          add_comment line.strip[1..-1]

        else
          add_code line
      end
    end

  end


```
convert each block to html
and wrap it in a styled page
if a file path passed it'll write output to it
in all cases it'll return the output
```ruby
  def to_html(file = nil)
    code = map.with_index do |block, i| 

```
each cell in resulted table
will have a class same as the
class name of teh block downcased
```ruby
          klass = block.class.to_s.downcase

```
start table row or end it
according to the current block index
```ruby
          prefix = i.even? ? '<tr>' : ''
          suffix = i.odd? ? '</tr>' : ''

```
produced block html
```ruby
          "#{prefix}<td class=\"section #{klass}\">#{block.to_html}</td>#{suffix}" 
        end


```
add a closing cell if the code
ends with comments lines
```ruby
    code << "<td></td></tr>" if last.is_a? CommentBlock


```
here is the full page with embeded style
i had to add the css here to make sure script stay as
one file not multiple dependent files.
```ruby
    html = <<-EOT
<html>
<head>
<style>
body { background: #29281e; padding:0px; margin:0px; font-family: verdana, tahoma; font-size: 13px; }
.content{ border-collapse: collapse; }
.section{ padding: 5px; border-top: 1px solid #333; } 
.commentblock{ width: 40%;text-align: right; vertical-align: top; font-size: 13px; color: #ddd; text-shadow: 1px 1px 0px black; }
.codeblock{ width: 60%; background: #29281e; border-left: 1px solid #333; padding-left: 10px; }
.commentblock a{ color: #fff; }
.codeblock pre{ white-space: pre-wrap; margin: 0px; }
.highlight { padding: 0px; font-size: 13px; }
div.highlight, div.highlight code, div.highlight pre  { padding: 0px; }div.highlight code { padding: 0; }div.highlight .c { color: #75715e }div.highlight .err { color: #960050; background-color: #1e0010 }div.highlight .k { color: #66d9ef }div.highlight .l { color: #ae81ff }div.highlight .n { color: #f8f8f2 }div.highlight .o { color: #f92672 }div.highlight .p { color: #f8f8f2 }div.highlight .cm { color: #75715e }div.highlight .cp { color: #75715e }div.highlight .c1 { color: #75715e }div.highlight .cs { color: #75715e }div.highlight .ge { font-style: italic }div.highlight .gs { font-weight: bold }div.highlight .kc { color: #66d9ef }div.highlight .kd { color: #66d9ef }div.highlight .kn { color: #f92672 }div.highlight .kp { color: #66d9ef }div.highlight .kr { color: #66d9ef }div.highlight .kt { color: #66d9ef }div.highlight .ld { color: #e6db74 }div.highlight .m { color: #ae81ff }div.highlight .s { color: #e6db74 }div.highlight .na { color: #a6e22e }div.highlight .nb { color: #f8f8f2 }div.highlight .nc { color: #a6e22e }div.highlight .no { color: #66d9ef }div.highlight .nd { color: #a6e22e }div.highlight .ni { color: #f8f8f2 }div.highlight .ne { color: #a6e22e }div.highlight .nf { color: #a6e22e }div.highlight .nl { color: #f8f8f2 }div.highlight .nn { color: #f8f8f2 }div.highlight .nx { color: #a6e22e }div.highlight .py { color: #f8f8f2 }div.highlight .nt { color: #f92672 }div.highlight .nv { color: #f8f8f2 }div.highlight .ow { color: #f92672 }div.highlight .w { color: #f8f8f2 }div.highlight .mf { color: #ae81ff }div.highlight .mh { color: #ae81ff }div.highlight .mi { color: #ae81ff }div.highlight .mo { color: #ae81ff }div.highlight .sb { color: #e6db74 }div.highlight .sc { color: #e6db74 }div.highlight .sd { color: #e6db74 }div.highlight .s2 { color: #e6db74 }div.highlight .se { color: #ae81ff }div.highlight .sh { color: #e6db74 }div.highlight .si { color: #e6db74 }div.highlight .sx { color: #e6db74 }div.highlight .sr { color: #e6db74 }div.highlight .s1 { color: #e6db74 }div.highlight .ss { color: #e6db74 }div.highlight .bp { color: #f8f8f2 }div.highlight .vc { color: #f8f8f2 }div.highlight .vg { color: #f8f8f2 }div.highlight .vi { color: #f8f8f2 }div.highlight .il { color: #ae81ff }
</style>
</head>
<body>
<table class="content">#{code.join}</table>
</body>
</html>
EOT
  

```
write output to file if a path is passed
and return html
```ruby
    File.write file, html unless file.nil?
    html
  end


```
Convert the analyzed code into Markdown
this is easier than HTML as you'll need
to convert each block to markdown and
join them with new line
write output to file if a path is passed
```ruby
  def to_md(file=nil)
    
    md = map {|b| b.to_md }.join "\n"
    
    File.write file, md unless file.nil?
    md
  end
  alias_method :to_markdown, :to_md

end


```
## How to use ?
create new Code Converter class with code
```ruby
blocks = CodeConverter.new( File.read('/path/to/code/file.rb') )

```
and convert to html and markdown and save it to this file path
```ruby
blocks.to_html '/path/to/html/code.html'
blocks.to_md '/path/to/md/markdown.md'
```