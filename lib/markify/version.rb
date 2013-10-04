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

module Markify

  VERSION = '0.2.2'
  NAME    = 'markify'

  DESCRIPTION =<<DESCRIPTION
#{Markify::NAME.capitalize} is a ruby script to detect new marks or course assessments in the student
information system of your university. If #{Markify::NAME} detects new marks, they will send you a XMPP message for
every change. Supported universities: University of Applied Sciences Bonn-Rhein-Sieg.
DESCRIPTION

  LICENCE =<<LICENCE
#{Markify::NAME.capitalize} - v#{Markify::VERSION}
Released under the GNU GENERAL PUBLIC LICENSE Version 3. © Daniel Meißner, 2013
LICENCE

  SUMMARY =<<SUMMARY
Mark notify script for different universities.
SUMMARY

end