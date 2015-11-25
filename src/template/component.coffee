###
Copy this `template` folder to kick off a new webgl setup.
Besure to register the component in `routes.coffee`
###

# Deps
CustomText = require './CustomText.coffee'

# Component definition
module.exports =
	template: require '../mixins/base.haml'

	mixins: [ require '../mixins/webgl-base.coffee' ]

	methods:
		###
		Called after the webgl-base scene is created for you.
		You can override the `setup()` method in this component to build a custom
		scene, camera, and renderer.
		###
		stageReady: () ->
			@text = new CustomText @scene

			# kick off the render loop
			@render()
			return

		###
		Hook to update your scene objects per loop. See `webgl-base.render()`
		for where this is called. It will request a new loop,
		render the scene, or update TWEENjs.
		###
		onRender: (time)->
			@text.update(time)
			return

		###
		Kill all your scene objects
		###
		onDeactivate: () ->
			delete @text
			return
