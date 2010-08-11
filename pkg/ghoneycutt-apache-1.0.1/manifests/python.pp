# Class: apache::python
#
# This module manages apache's mod_python
#
# Requires:
#   class apache
#
# Sample Usage: include apache::python
#
class apache::python {

    include apache

    package { "mod_python":
        require => Apache::Module["ssl"],
    } # package

    apache::module{ "python": 
        source => "puppet:///modules/apache/python.conf",   
    } # apache::module
} # class apache::python
