###
Copy this `template` folder to kick off a new webgl setup.
Besure to register the component in `routes.coffee`
###

# Deps
CustomText = require './CustomText.coffee'
MessagePane = require './MessagePane.coffee'
data = require './data.cson'

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
			@renderer.setClearColor( 0x556270, 1);
			@renderer.alpha = false
			@size = data.length

			@panes = _.map data, (datum, index) =>
				return new MessagePane @scene,
					data: datum
					index: index
					position: new THREE.Vector3 index,0,0
					size: @size

			@light = new THREE.DirectionalLight
				color: 0xffffff
			@light.rotation.set Math.PI / 2, 0,0
			@light.position.set 0,1,2
			@light.intesity = 1
			@scene.add @light

			@light2 = new THREE.DirectionalLight
				color: 0xffffff
			@light2.rotation.set Math.PI / 2, 0,0
			@light2.position.set -3,-1,3
			@light2.intesity = 1
			@scene.add @light2

			@light2 = new THREE.DirectionalLight
				color: 0xffffff
			@light2.rotation.set Math.PI / 2, 0,0
			@light2.position.set -3,-1,3
			@light2.intesity = 1
			@scene.add @light2

			@index = 0
			@animatePanes()

			# kick off the render loop
			@render()
			return

		animatePanes: () ->
			_.each @panes, (pane,i) =>
				pane.animate(@index)
			return

		onClick: (e) ->
			@index++
			if @index >= @size
				@index = 0
			@animatePanes()
			return

		###
		Hook to update your scene objects per loop. See `webgl-base.render()`
		for where this is called. It will request a new loop,
		render the scene, or update TWEENjs.
		###
		onRender: (time)->
			# @text.update(time)
			return

		###
		Kill all your scene objects
		###
		onDeactivate: () ->
			# delete @text
			return
