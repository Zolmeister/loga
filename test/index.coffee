assert = require 'assert'

log = require '../src'

describe 'loga', ->
  it 'logs debug default', ->
    log 'debug'

  it 'logs types', ->
    log.trace 'trace'
    log.debug 'debug'
    log.info 'info'
    log.warn 'warn'
    log.error 'error'

  it 'obeys level', ->
    originalLevel = log.level
    log.level = 'warn'
    log.trace 'THIS SHOULD NOT LOG'
    log.debug 'THIS SHOULD NOT LOG'
    log.info 'THIS SHOULD NOT LOG'
    log.warn 'warn'
    log.error 'error'
    log.level = originalLevel

  it 'obeys null level', ->
    originalLevel = log.level
    log.level = null
    log.trace 'THIS SHOULD NOT LOG'
    log.debug 'THIS SHOULD NOT LOG'
    log.info 'THIS SHOULD NOT LOG'
    log.warn 'THIS SHOULD NOT LOG'
    log.error 'THIS SHOULD NOT LOG'
    log.level = originalLevel

  it 'binds', (done) ->
    log.on 'warn', (msg) ->
      assert.equal msg, 'test'
      done()

    log.info 'null'
    log.warn 'test'
