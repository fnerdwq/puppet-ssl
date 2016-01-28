# installs openssl (private)
class ssl::install {
  if ! defined(Package['openssl']) { package { 'openssl': ensure => installed } }
}
