View = require '../lib/view'
Template = require '../templates/fangate'

module.exports = class FangateView extends View
    template: Template
    className: 'fangate'
    initialize: ->
        @render()