#!/usr/bin/env ruby
# encoding: utf-8

require 'mechanize'
require 'date'
require 'xmpp4r/client'
require 'digest'

@debug = false
@marks = []

agent = Mechanize.new

agent.get('https://dias.fh-bonn-rhein-sieg.de/d3/SISEgo.asp?UserAcc=Gast&DokID=DiasSWeb&ADias2Dction=Login') do |page|
  page_after_login = page.form_with(action: '/d3/SISEgo.asp?formact=Login') do |f|
    f.txtBName    = "fbar2s"
    f.txtKennwort = "möpmöp"
  end.click_button

  if link = page_after_login.link_with(text: "Notenspiegel (vollständig)")
    mark_page   = link.click
    marks_table = mark_page.search(".//*[@id='inhalt']/table/tbody/tr/td/center/table/tr")

    marks_table.each do |m|
      mark = m.search('./td')

      unless mark[0].text =~ /\d{4,5}/
        next
      end

      @marks << { id: (Digest::SHA256.new << "#{mark[1].text}#{mark[12].text}#{mark[4].text}#{mark[8].text}#{mark[7].text}").to_s, name: mark[1].text, date: Date.strptime(mark[12].text, '%d.%m.%Y'), mark: mark[4].text, try: mark[8].text, passed: mark[7].text }
    end
  end
end

@marks.each{|mark| p mark} if @debug

def check_new_marks
  new_marks = @marks.clone

  File.open(Dir.pwd + "/marks.txt", 'a+').read.split(/\n/).each do |line|
    @marks.each do |mark|
      if mark[:id].match(line)
        new_marks.delete(mark)
      end
    end
  end

  return new_marks
end

def send_xmpp_message(new_marks)
  bot = Jabber::Client.new('bot@jab.ber.de/bot')
  bot.connect
  bot.auth('müpmüp')

  receiver = "foo@baz.er"

  puts "\nNew marks found: " if @debug && new_marks.count > 0

  new_marks.sort_by{|mark| mark[:date]}.each do |mark|
    message =<<MESSAGE

== New mark available ==

exam: #{mark[:name]}
mark: #{mark[:mark]}
passed: #{mark[:passed]}
try: #{mark[:try]}
date: #{mark[:date]}

MESSAGE

    if @debug
      puts mark[:id]
      puts mark[:name]
      puts mark[:mark]
      puts mark[:passed]
      puts
    else
      bot.send(Jabber::Message.new(receiver, message)) unless mark[:passed] =~ /AN/
    end

    File.open(Dir.pwd + "/marks.txt", 'a+') do |f|
      f.puts mark[:id]
    end
  end
end

send_xmpp_message(check_new_marks)
