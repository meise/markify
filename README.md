# Markify

Markify is a ruby script to detect new marks or course assessments in the student information system of your university.
Supported universities are:

* [University of Applied Sciences Bonn-Rhein-Sieg](http://h-brs.de)

If new marks are detected, Markify will send you a [XMPP](http://xmpp.org/) message for every change.

The main reason for creating Markify is some kind of disappointing. Our university is able to publish the results of
exams online, but the web based student information system is not able to send notifications if something is changed.
That is very annoying especially in the time when you have to write exams, but you also waiting for results.

What Markify does is to do the same procedure which would you do to look for new marks.

1. Go to the student information system login page.
2. Login with your 	user data.
3. Go to your performance record.
4. Scrape the page.
5. Recognize changes.
6. Send notifications.

The benefit of Markify against your manual interaction is, that you can run Markify automatically per cron.

## Installation

Install Markify via rubygems:

    $ gem install markify

## Usage

1. Create the initial Markify configuration.

        $ markify --init

2. Add your student information system and XMPP login data to your configuration. Default path ``$HOME/markify/config.yml``.

3. Test your configuration.

        $ markify --test

4. Run Markify to create hash database and insert all known marks.

        $ markify -v

5. Configure cron job to run Markify every hour.

        $ crontab -e

        @hourly /usr/local/bin/bash -c "/usr/local/bin/markify -s" 1>/dev/null

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
            --version                    Show version information

## Notification example

    exam:   BCS-3-SPEZ Transportnetze und Hochgeschwindigkeitsnetze
    mark:   1.7
    passed: BE
    try:    3
    date:   2042-01-23

    hash:   05d48ced524708314d4ff2e628f7200b06f02ed2e40a36efd92bbf449f474cce

## Contribution

The Markify source code is [hosted on GitHub](https://github.com/meise/markify). Please use the
[issue tracker](https://github.com/meise/markify/issues) and let me know about errors or ideas to improve this software.

## License

Released under the GNU GENERAL PUBLIC LICENSE Version 3. © Daniel Meißner, 2013
