# == Class: post2sms
#
# set up a proxy to receive POST requests and send SOAP calls
# to trigger an SMS
#

class post2sms (
  $host        = 'post2sms.local',
  $gw_host     = 'https://smsgateway.t-online.de/tomessage',
  $appid       = '',
  $appsec      = '',
  $pmi_key     = 'FREE_SMS',
  $guid        = '',
  $anid        = ''
) {

  if(!$appid) {
    fail('appid is not set')
  }
  if(!$appsec) {
    fail('appsec is not set')
  }
  if(!$guid) {
    fail('guid is not set')
  }
  if(!$anid) {
    fail('anid is not set')
  }

  class { 'nginx':
        manage_repo => false,
  }

  # remove dummy files created by ubuntu nginx installation
  file { '/etc/nginx/conf.d/default.conf':
    ensure    => absent,
    subscribe => Package['nginx'],
  }
  file { '/etc/nginx/conf.d/example_ssl.conf':
    ensure    => absent,
    subscribe => Package['nginx']
  }


  # the post arguments
  $number      = '$arg_number'
  $sender      = '$arg_sender'
  $message     = '$request_body'

  # define the vhost
  nginx::resource::vhost { $host:
    ensure           => present,
    proxy            => $gw_host,
    proxy_set_header => [
      'SOAPAction "http://planb.de/TOMessage#sendMessage"',
      'Content-Type "text/xml; charset=utf-8"'
    ],
    proxy_method     => 'POST',
    proxy_set_body   => put_in_quotes( template('post2sms/soap-call.erb') )
  }

}
