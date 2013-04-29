# Markify

Markify is ruby Script to detect new marks in the
Studierendeninformationssystem (SIS) of the University of Applied Sciences
Bonn-Rhein-Sieg. If markify detects new marks, they will send you a xmpp
message for every change.

## Installation

Install Markify via rubygems:

    $ gem install markify

## Usage

To create the initial markify configuration run:

    $ markify --init

The default configuration path is ``/home/$user/markify/config.yml``. You have to add your SIS and xmpp login data.

Possible options to run markify:

    $ markify [options]

    Optional options:
        -s, --send                       Send xmpp messages
        -n, --noop                       No operation, only stout output
        -v, --[no-]verbose               Run verbosely

        -f, --config-file FILE           Config file (default: ~/markify/config.yml)

    Common options:
            --init                       Create example configuration
            --test                       Test configuration and accounts
        -h, --help                       Show this message
            --version                    Show version inforamtion

## License

Released under the GNU GENERAL PUBLIC LICENSE Version 3. © Daniel Meißner, 2013