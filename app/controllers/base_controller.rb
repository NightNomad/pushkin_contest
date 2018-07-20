class BaseController < ApplicationController

  def base
    #URL = "http://ilibrary.ru/text/"

    mechanize = Mechanize.new { |agent|
      agent.user_agent_alias = 'Linux Firefox'
    }

    page = mechanize.get("http://ilibrary.ru/author/pushkin/l.all/index.html")
    links = page.parser.css('.list a')

    id_poems = links.map { |l| l.attributes['href'].value }
      .select { |l| l =~ %r{/text/\d+/index\.html} }
      .map { |l| l.scan(/\d+/)[0] }.uniq

    num = 0
    size = id_poems.size

    id_poems.each do |id|
      link = "http://ilibrary.ru/text/" + id + "/p.1/index.html"

      page = mechanize.get(link)

      title = page.parser.css('.title h1').text
      text = page.parser.css('.poem_main').text
      text.gsub!(/\u0097/, "\u2014") # replacement of unprintable symbol
      text.gsub!(/^\n /, "") # remove first \n

      poem = Poem.new
      poem.title = title
      poem.poem = text
      poem.save
    end

  end
end
