{Range} = require 'atom'
module.exports =
class Lint

  manager: null
  decorations: null

  constructor: (manager, state = {}) ->
    @manager = manager
    @decorations = []

  setMarkers: (data) ->
    editor = atom.workspace.getActiveTextEditor()
    buffer = editor.getBuffer()
    @destroyDecorations()
    for message in data.messages
      range = new Range(buffer.positionForCharacterIndex(message.from), buffer.positionForCharacterIndex(message.to))
      marker = editor.markBufferRange(range, invalidate: 'touch')
      return unless marker
      @decorations.push(editor.decorateMarker(marker, {type: 'highlight', class: 'atom-ternjs-lint'}))

  destroyDecorations: ->
    for decoration in @decorations
      decoration.destroy()

  destroy: ->
    @destroyDecorations()