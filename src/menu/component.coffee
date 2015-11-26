###
The marquee
###

# Deps
require './style.styl'

# Component definition
module.exports =
	template: require './template.haml'
	inherit: true

	data: () ->
		return {
			routes: require '../routes.coffee'
			classes:
				open: false
		}

	ready: () ->
		return

	methods:
		toggle: () ->
			@classes.open = !@classes.open
			return

		close: () ->
			@classes.open = false

		open: () ->
			@classes.open = true
