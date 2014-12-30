package_json = require '../package.json'
{ExtendedLogger, ProjectCredentialsConfig} = require 'sphere-node-utils'
ipinfo = require 'ipinfo'
CreateCart = require './createcart'

argv = require('optimist')
  .usage('Usage: $0 --projectKey [key] --clientId [id] --clientSecret [secret] --logDir [dir] --logLevel [level]')
  .describe('projectKey', 'your SPHERE.IO project-key')
  .describe('clientId', 'your OAuth client id for the SPHERE.IO API')
  .describe('clientSecret', 'your OAuth client secret for the SPHERE.IO API')
  .describe('logLevel', 'log level for file logging')
  .describe('logDir', 'directory to store logs')
  .describe('logSilent', 'use console to print messages')
  .default('logLevel', 'info')
  .default('logDir', '.')
  .default('logSilent', false)
  .demand(['projectKey'])
  .argv

logOptions =
  name: "#{package_json.name}-#{package_json.version}"
  streams: [
    { level: 'error', stream: process.stderr }
    { level: argv.logLevel, path: "#{argv.logDir}/#{package_json.name}.log" }
  ]
logOptions.silent = argv.logSilent if argv.logSilent
logger = new ExtendedLogger
  additionalFields:
    project_key: argv.projectKey
  logConfig: logOptions
if argv.logSilent
  logger.bunyanLogger.trace = -> # noop
  logger.bunyanLogger.debug = -> # noop

country = ""

ipinfo (err, info) ->
  if err
    logger.error err, 'Oops, something went wrong when trying to reach ipinfo.io API.'
    @exitCode = 1

  country = info.country

  ProjectCredentialsConfig.create()
  .then (credentials) =>
    options =
      config: credentials.enrichCredentials
        project_key: argv.projectKey
        client_id: argv.clientId
        client_secret: argv.clientSecret
    createCart = new CreateCart options
    createCart.run(country)

  .catch (err) =>
    logger.error err, "Problems on getting client credentials from config files."
    @exitCode = 1
  .done()