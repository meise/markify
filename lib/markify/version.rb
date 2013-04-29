# encoding: utf-8

module Markify

  VERSION = '0.1.0'
  NAME    = 'markify'

  DESCRIPTION =<<DESCRIPTION
#{Markify::NAME.capitalize} is a ruby script to detect new marks in the
Studierendeninformationssystem (SIS) of the University of Applied Sciences
Bonn-Rhein-Sieg. If #{Markify::NAME} detects new marks, they will send you a xmpp
message for every change.
DESCRIPTION

  LICENCE =<<LICENCE
#{Markify::NAME.capitalize} - v#{Markify::VERSION}
Released under the GNU GENERAL PUBLIC LICENSE Version 3. © Daniel Meißner, 2013
LICENCE

  SUMMARY =<<SUMMARY
Mark notify script for the Studierendeninformationssystem (SIS) of the University of Applied Sciences Bonn-Rhein-Sieg.
SUMMARY

end