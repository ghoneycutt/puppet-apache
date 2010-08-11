# Class: apache::perl
#
# This module manages apache's mod_perl
#
# Requires:
#   class apache
#
# Sample Usage: include apache::perl
#
class apache::perl {

    include apache

    package { "mod_perl": }

    apache::module { "perl": 
        source => "puppet:///modules/apache/perl.conf",
    } # apache::module
} # class apache::perl
