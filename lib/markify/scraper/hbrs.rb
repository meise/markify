# encoding: utf-8
=begin
Copyright Daniel Meißner <meise+markify@3st.be>, 2013

This file is part of Markify.

Markify is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Markify is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Markify. If not, see <http://www.gnu.org/licenses/>.
=end

class Markify::Scraper::Hbrs < Markify::Scraper::Base

  def initialize(login_name, login_password)
    super(login_name,
          login_password,
          'https://dias.fh-bonn-rhein-sieg.de/d3/SISEgo.asp?UserAcc=Gast&DokID=DiasSWeb&ADias2Dction=Login'
    )
  end

  def test_login
    login_page = @agent.get(@data[:login_page])
    error_page = sis_login(@data[:login_name], @data[:login_password], login_page)

    if error_page.search(".//*[@id='inhalt']/table/tbody/tr/td/form/center/table/tr[3]/td").text =~
        /Benutzername unbekannt oder falsches Kennwort eingegeben!/
      puts "SIS: Username and password wrong."
    else
      puts "SIS: Login works."
    end
  end

  protected

  def scrape
    login_page = @agent.get(@data[:login_page])

    first_sis_page = sis_login(@data[:login_name], @data[:login_password], login_page)
    marks_table    = get_marks_table(first_sis_page)

    get_marks(marks_table)
  end

  def get_marks(marks_table)
    marks_table.each do |m|
      mark = m.search('./td')

      # use only lines with a id
      unless mark[0].text =~ /\d{4,5}/
        next
      end

      @marks << Markify::Mark.new(
          mark[1].text, # curse name
          mark[0].text, # id
          mark[4].text, # mark
          mark[7].text, # passed
          mark[8].text, # try
          mark[12].text # date
      )
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