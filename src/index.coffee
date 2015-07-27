levels = ['trace', 'debug', 'info', 'warn', 'error']
listeners = {}

logger = (args...) -> logger.debug.apply logger, args
logger.level = 'trace'

log = (level, args) ->
  isDisabled = logger.level is null
  isSilenced = levels.indexOf(level) < levels.indexOf(logger.level)
  if isDisabled or isSilenced
    return null

  fn = console[level] or console.log
  fn.apply console, args
  if listeners[level]
    for listener in listeners[level]
      listener.apply null, args

for level in levels
  logger[level] = do (level) ->
    (args...) -> log level, args

logger.on = (key, fn) ->
  listeners[key] ?= []
  listeners[key].push fn

module.exports = logger
