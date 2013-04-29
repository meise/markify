# encoding: utf-8

require 'mechanize'

class Markify::Scraper

  attr_reader :marks

  def initialize(login_name, login_password, sis_login_page = nil)
    @agent = Mechanize.new

    @sis                  = {}
    @sis[:login_page]     = sis_login_page || 'https://dias.fh-bonn-rhein-sieg.de/d3/SISEgo.asp?UserAcc=Gast&DokID=DiasSWeb&ADias2Dction=Login'
    @sis[:login_name]     = login_name
    @sis[:login_password] = login_password

    @marks = []

    scrape
  end

  def scrape
    scrape!
  end

  protected

  def scrape!
    page = @agent.get(@sis[:login_page])

    first_sis_page = sis_login(@sis[:login_name], @sis[:login_password], page)
    marks_table    = get_marks_table(first_sis_page)

    get_marks(marks_table)
  end

  def get_marks(marks_table)
    marks_table.each do |m|
      mark = m.search('./td')

      unless mark[0].text =~ /\d{4,5}/
        next
      end

      @marks << Markify::Mark.new(mark[1].text, mark[0].text, mark[4].text, mark[7].text, mark[8].text, mark[12].text)
    end

    @marks
  end

  def get_marks_table(page_after_login)
    marks_table = nil

    if link = page_after_login.link_with(text: "Notenspiegel (vollständig)")
      mark_page   = link.click
      marks_table = mark_page.search(".//*[@id='inhalt']/table/tbody/tr/td/center/table/tr")
    else
      puts "Page after login not available."
      exit
    end

    marks_table
  end

  def sis_login(name, password, login_page)
    page_after_login = login_page.form_with(action: '/d3/SISEgo.asp?formact=Login') do |form|
      form.txtBName    = name
      form.txtKennwort = password
    end.click_button
  end
end