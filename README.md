# Markify

Markify is a ruby script to detect new marks in the
[Studierendeninformationssystem](http://sis.fh-bonn-rhein-sieg.de) (SIS) of the [University of Applied Sciences
Bonn-Rhein-Sieg](http://h-brs.de). If markify detects new marks, they will send you a xmpp
message for every change.

## Installation

Install Markify via rubygems:

    $ gem install markify

## Usage

1. Create the initial markify configuration.

        $ markify --init

2. Add your SIS and xmpp login data to your configuration. Default path ``$HOME/markify/config.yml``.

3. Test your configuration

        $ markify --test

4. Run markify to create hash database and insert all known marks.

        $ markify -v

5. Configure cron job to run markify every hour.

        $ crontab -e

        @hourly /usr/local/bin/bash -c "/usr/local/bin/markify -s"

Possible options to run markify:

    $ markify [options]

    Optional options:
        -s, --send                       Send xmpp messages
        -n, --noop                       No operation, only stdout output
        -v, --[no-]verbose               Run verbosely

        -f, --config-file FILE           Config file (default: ~/markify/config.yml)

    Common options:
            --init                       Create example configuration
            --test                       Test configuration and accounts
        -h, --help                       Show this message
            --version                    Show version inforamtion

## Notification example

    exam:   BCS-3-SPEZ Transportnetze und Hochgeschwindigkeitsnetze
    mark:   1.7
    passed: BE
    try:    3
    date:   2042-01-23

    hash:   05d48ced524708314d4ff2e628f7200b06f02ed2e40a36efd92bbf449f474cce

## License

Released under the GNU GENERAL PUBLIC LICENSE Version 3. © Daniel Meißner, 2013