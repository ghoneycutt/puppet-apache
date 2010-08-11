# Class: apache::php
#
# This module manages apache's mod_php
#
# Requires:
#   class apache
#
# Sample Usage: include apache:php
#
class apache::php {

    include apache

    package { "php": }

    apache::module{ "php": 
        source => "puppet:///modules/apache/php.conf",   
    } # apache::module
} # class apache::php
