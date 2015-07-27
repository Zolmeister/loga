assert = require 'assert'

log = require '../src'

describe 'loga', ->
  it 'logs debug', ->
    log.debug 'abc'
