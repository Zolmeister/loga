levels = ['trace', 'debug', 'info', 'warn', 'error']
listeners = {}

# see lodash 3.10.1 source
isPlainObject = (value) ->
  unless typeof value is 'object'
    return false

  Ctor = value.constructor

  isArguments = (value) ->
    typeof value is 'object' and
    value.length? and
    value.hasOwnProperty?('callee') and
    not value.propertyIsEnumerable? 'callee'

  if not (
    String(value) is '[object Object]' and
    not isArguments(value)
  ) or (
    not value.hasOwnProperty?('constructor') and
    typeof Ctor is 'function' and not Ctor instanceof Ctor
  )
    return false

  res = null
  for key of value
    res = key
  res is null or value.hasOwnProperty? res

logger = (args...) -> logger.debug.apply logger, args
logger.level = 'trace'

log = (level, args) ->
  isDisabled = logger.level is null
  isSilenced = levels.indexOf(level) < levels.indexOf(logger.level)
  if isDisabled or isSilenced
    return null

  stringArgs = []
  for arg, i in args
    if isPlainObject arg
      try
        stringArgs[i] = JSON.stringify arg
      catch
        stringArgs[i] = arg
    else
      stringArgs[i] = arg

  fn = console[level] or console.log
  fn.apply console, stringArgs
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
