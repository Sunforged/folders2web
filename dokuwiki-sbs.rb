# encoding: UTF-8

# Add a text field 
$:.push(File.dirname($0))
require 'utility-functions'
require 'appscript'
include Appscript

# asks for the name of a page, and presents it side-by-side with the existing page, in editing mode if it's a wiki page

dt=app('Google Chrome')

page = wikipage_selector(title)
exit unless page

cururl = dt.windows[1].get.tabs[dt.windows[1].get.active_tab_index.get].get.URL.get

if cururl.index("localhost/wiki")
  cururl = cururl.to_s + "?do=edit&vecdo=print"
end

newurl = "http://localhost/wiki/#{page.gsub(" ","_")}"

js = "var MyFrame=\"<frameset cols=\'*,*\'><frame src=\'#{cururl}\'><frame src=\'#{newurl}?do=edit&vecdo=print\'></frameset>\";with(document) {    write(MyFrame);};return false;"

dt.windows[1].get.tabs[dt.windows[1].get.active_tab_index.get].get.execute(:javascript => js)