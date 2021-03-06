package_json = require '../package.json'
{ExtendedLogger, ProjectCredentialsConfig} = require 'sphere-node-utils'
GetCountry = require './getcountry'
GetCurrency = require './getcurrency'
CreateCart = require './createcart'

argv = require('optimist')
  .usage('Usage: $0 --projectKey [key] --clientId [id] --clientSecret [secret] --ipAddress [address] --logDir [dir] --logLevel [level]' )
  .describe('projectKey', 'your SPHERE.IO project-key')
  .describe('clientId', 'your OAuth client id for the SPHERE.IO API')
  .describe('clientSecret', 'your OAuth client secret for the SPHERE.IO API')
  .describe('ipAddress', 'IP used to determine country')
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

ProjectCredentialsConfig.create()
.then (credentials) ->
  options =
    config: credentials.enrichCredentials
      project_key: argv.projectKey
      client_id: argv.clientId
      client_secret: argv.clientSecret
  getCountry = new GetCountry logger
  getCurrency = new GetCurrency logger
  createCart = new CreateCart options
  getCountry.run(argv.ipAddress)
  .then (country) ->
    getCurrency.run(country)
    .then (currency) ->
      createCart.run(country, currency)
    .catch (err) ->
      logger.error err, "Problems while creating the cart."
      process.exit(1)
    .done()
  .catch (err) ->
    logger.error err, "Problem while fetching currency."
    process.exit(1)
  .done()
.catch (err) ->
  logger.error err, "Problems on getting client credentials from config files."
  process.exit(1)
.done()