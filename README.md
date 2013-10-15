# puppet-post2sms

Simple puppet module to set up a proxy to receive POST requests and send SOAP calls to trigger an SMS.

It works by issuing an:

    http post proxyserver/?number=0049151...&name=luke "the force is throwing alarms"

which contain the name und number in its url parameters and the message for the sms in its body. This in turn will proxy a SOAP call to the destination to trigger an SMS.

## Testing the module

If you can't control the SOAP-Endpoint and receive an SMS, you can still verify it is working correctly by looking at the SOAP request that is generated.

The following steps will describe this configuration. You can also use the contained Vagrant environment which is already configured for this case.

Install it via puppet:

    class { 'post2sms':
      gw_host => 'http://localhost:8081'
    }

Open a listener to capture the request (for Vagrant: do this inside the VM):

    nc -l 8081

Issue a POST request to the proxy (for Vagrant: on the host):

    curl 'localhost:8080/?name=luke&number=0012321' -d "the force is throwing alarms"

Look at your listener, it will have captured the request.