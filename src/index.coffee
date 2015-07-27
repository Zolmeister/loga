class Logger
  debug: (abc) ->
    console.log abc


logger = new Logger()

debugFn = logger.debug
for key, val of logger
  debugFn[key] = val

module.exports = debugFn
