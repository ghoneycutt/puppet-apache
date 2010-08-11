# Class: apache::hup
#
# This module allows you to restart apache via ssh and sudo
# You will need to configure sudo as specified in the README
# 
# Requires:
#   class ssh
#   class pam
#   class generic
#   class sudo
#   specify the apachehup user in class generic
#   public and private keys
#
# Sample Usage: include apache::hup
#
class apache::hup { 

    include ssh

    realize Generic::Mkuser[apachehup]

    # Add apachehup's key to authorized_keys. Note this depends on the
    # apachehup user being able to restart apache with sudo.
    ssh::authorized_keys { "apachehup":
       users   => [ "apachehup" ],
       require => Generic::Mkuser[apachehup],
   }

    # allow apachehup the ability to login to the system
    pam::accesslogin { "apachehup": }
} # class apache::hup
