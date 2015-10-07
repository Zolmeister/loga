# loga

finally a reasonable logger

```coffee
log = require 'loga'

log('debug by default')
log.trace 'trace'
log.debug 'debug'
log.info 'info'
log.warn 'warn'
log.error 'error'
log {auto: 'stringify'} # objects stringified automatically

log.level = 'warn' # limit to warn or above
log.level = null # silence

log.on 'warn', (args...) ->
  # do something with log
```
