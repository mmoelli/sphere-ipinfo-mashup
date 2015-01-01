# SPHERE.IO/ipinfo.io connector

[![Build Status](https://travis-ci.org/mmoelli/sphere-ipinfo-mashup.svg?branch=master)]

This small helper creates automatically carts in your [SPHERE.IO](https://admin.sphere.io) project where the country is set to the origin of the used IP address. To obtain the country the [ipinfo.io](http://ipinfo.io) API.

## Usage

General command line options can be seen by simply executing the command `node lib/run`.
```
node lib/run

  Usage:     --projectKey <project-key> --clientId <client-id> --clientSecret <client-secret>

  Options:

    --projectKey <key>               your SPHERE.IO project-key
    --clientId <id>                 your OAuth client id for the SPHERE.IO API
    --clientSecret <secret>         your OAuth client secret for the SPHERE.IO API
    --ipAddress <ip-address>        the IP address you want to use for the cart creation  [if not set, the server address will be used]
    --logLevel [level]              specifies log level (error|warn|info|debug|trace)     [default: info]
    --logDir [directory]            specifies log file directory [.]
    --logSilent                     use console to print messages                         [default: false]
```