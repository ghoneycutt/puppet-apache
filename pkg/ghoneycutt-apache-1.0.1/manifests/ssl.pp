# Class: apache::ssl
#
# This module manages apache's mod_ssl
#
# Requires:
#   class apache
#   $contactEmail be set in site manifest
#
# Sample Usage: include apache:ssl
#
class apache::ssl {

    include apache

    package { "mod_ssl":
        require => Apache::Module["ssl"],
    }

    apache::module{"ssl": 
        source => "puppet:///modules/apache/ssl.conf",   
    }

    # Definition: apache::ssl::set_cert
    #
    # install certificate
    #
    # Parameters:   
    #   $certfile   - public cert
    #   $certkey    - private key
    #   $ip         - ip address to use, uses $ipaddress from facter by default
    #   $port       - port to use, uses 443 by default
    #   $cachain    - cachain file
    #   $revokefile - revoke file
    #
    # Actions:
    #   installs certs
    #
    # Requires:
    #   $certfile must be set
    #   $certkey must be set
    #
    # Sample Usage:
    #    # *.yoursite.com
    #    @set_cert { "staryoursite":
    #        certfile => "/etc/pki/tls/certs/yoursite_cert.pem",
    #        certkey  => "/etc/pki/tls/private/yoursite_key.pem",
    #    } # @set_cert
    define set_cert ($certfile, $certkey, $ip = $ipaddress, $port = "443", $cachain = undef, $cafile = undef, $revokefile = undef) {
        apache::module{"ssl-$name":
            content => template("apache/ssl_site.conf.erb"),
        }
     } # define set_cert
        
    #rh specific default cert
    @set_cert { "default":
        certfile => "/etc/pki/tls/certs/localhost.crt",
        certkey  => "/etc/pki/tls/private/localhost.key",
    } # @set_cert
   
    # *.yoursite.com
    #@set_cert { "staryoursite":
    #    certfile => "/etc/pki/tls/certs/yoursite_cert.pem",
    #    certkey  => "/etc/pki/tls/private/yoursite_key.pem",
    #} # @set_cert

} # class apache::ssl
