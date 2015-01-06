# == Class: google_chrome
#
# This class takes care of installing Google Chrome.
# 
# === Authors
#
# Luca Invernizzi <invernizzi.l@gmail.com>
#

class google_chrome {

  include wget

  #---------------------------------------------------------------------------
  # Download the file

  file {'/tmp/chrome.deb':
    ensure  => present,
    require => Wget::Fetch['google-chrome-beta']
  }

  wget::fetch { "google-chrome-beta":
    source      => 'https://dl.google.com/linux/direct/google-chrome-beta_current_amd64.deb',
    destination => '/tmp/chrome.deb',
    timeout     => 20,
    verbose     => false,
  }
  #---------------------------------------------------------------------------

  #---------------------------------------------------------------------------
  # Install it. We use gdebi as in installer because it automatically resolves
  # dependencies of .deb files.

  package { 'gdebi':
    ensure => installed
  }

  exec {'google-chrome-beta':
    command   => 'sudo gdebi -n /tmp/chrome.deb',
    creates   => '/usr/bin/google-chrome-beta',
    # logoutput => true,
    # loglevel  => crit,
    require   => [File['/tmp/chrome.deb'], Package['gdebi']]
    }
  #---------------------------------------------------------------------------

}
