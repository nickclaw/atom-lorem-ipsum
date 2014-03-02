window.lorem = require 'lorem-ipsum'

module.exports =
    configDefaults:
        wordRange: [6,15]
        sentenceRange: [4,10]
        paragraphRange: [3,5]

    activate: (state) ->

        # list for events
        atom.workspaceView.command '
            lorem-ipsum:sentence
            lorem-ipsum:paragraph
            lorem-ipsum:paragraphs', @generate

    generate: (evt) ->
        console.log evt
        editor = atom.workspace.getActiveEditor()
        config = atom.config.get('atom-lorem-ipsum')
        options =
            units: 'paragraphs'
            format: 'plain'
            sentenceLowerBound: parseInt config.wordRange[0]
            sentenceUpperBound: parseInt config.wordRange[1]
            paragraphLowerBound: parseInt config.sentenceRange[0]
            paragraphUpperBound: parseInt config.sentenceRange[1]
            count: 1

        options.units = 'sentence' if evt.type == 'lorem-ipsum:sentence'
        options.count = Math.floor(
            parseInt(config.paragraphRange[0]) + Math.random() *
            parseInt(config.paragraphRange[1] - config.paragraphRange[0])
        ) if evt.type == 'lorem-ipsum:paragraphs'

        editor?.insertText lorem options
