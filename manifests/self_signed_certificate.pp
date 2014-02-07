# generates a self sigend ssl certificate
define ssl::self_signed_certificate (
  $common_name      = $::fqdn,
  $email_address    = undef,
  $country          = undef,
  $state            = undef,
  $locality         = undef,
  $organization     = undef,
  $unit             = undef,
  $subject_alt_name = undef,
  $days             = 365,
  $directory        = '/tmp',
  $owner            = root,
  $group            = root,
) {

  if ! is_domain_name($common_name) {
    fail('$common_name must be a domain name!')
  }
  validate_string($email_address)
  validate_string($country)
  validate_string($state)
  validate_string($locality)
  validate_string($organization)
  validate_string($unit)
  validate_string($subject_alt_name)
  validate_re($days,'^\d+$')
  validate_absolute_path($directory)
  validate_string($owner)
  validate_string($group)

  include ssl::install

  Exec {
    path => ['/usr/bin']
  }

  # basename for key and certificate
  $basename="${directory}/${name}"

  ensure_resource('file', $directory, { ensure => directory })

  # create configuration file
  file {"${basename}.cnf":
    content => template('ssl/cert.cnf.erb'),
    owner   => $owner,
    group   => $group,
    require => File[$directory],
    notify  => Exec["create certificate ${name}.crt"],
  }

  # create private key
  exec {"create private key ${name}.key":
    command => "openssl genrsa -out ${basename}.key",
    creates => "${basename}.key",
    before  => File["${basename}.key"],
    notify  => Exec["create certificate ${name}.crt"]
  }
  file {"${basename}.key":
    mode  => '0600',
    owner => $owner,
    group => $group,
  }

  # create certificate
  exec {"create certificate ${name}.crt":
    command     => "openssl req -new -x509 -days ${days} -config ${basename}.cnf -key ${basename}.key -out ${basename}.crt",
    refreshonly => true,
    before      => File["${basename}.crt"],
  }
  file {"${basename}.crt":
    mode  => '0644',
    owner => $owner,
    group => $group,
  }

}
