###
Copy this `template` folder to kick off a new webgl setup.
Besure to register the component in `routes.coffee`
###

# Deps
Cube = require './Cube.coffee'

# Component definition
module.exports =
	template: require './template.haml'

	mixins: [ require '../mixins/webgl-base.coffee' ]

	data: () ->
		return {
			size: [16,9]
		}

	methods:
		###
		Called after the webgl-base scene is created for you.
		You can override the `setup()` method in this component to build a custom
		scene, camera, and renderer.
		###
		stageReady: () ->
			@group = new THREE.Group()
			@cubes = []

			for x in [0...@size[0]]
				for y in [0...@size[1]]
					@cubes.push new Cube @group,
						position: new THREE.Vector3 x-0.01, y, 0


			@scene.add @group
			@group.position.set -@size[0]/2+0.5, -@size[1]/2+0.5, 5

			@light = new THREE.DirectionalLight()
			@light.position.set 0,0,5
			@light.intensity = 1
			@scene.add @light

			# @light2 = new THREE.DirectionalLight()
			# @light2.position.set 0,-5,5
			# @light2.intensity = 0.5
			# @scene.add @light2

			# kick off the render loop
			@render()
			return

		###
		Hook to update your scene objects per loop. See `webgl-base.render()`
		for where this is called. It will request a new loop,
		render the scene, or update TWEENjs.
		###
		onRender: (time)->
			return

		onClick: () ->
			_.each @cubes, (cube, index) ->
				cube.tween(index)
			return

		###
		Kill all your scene objects
		###
		onDeactivate: () ->
			return
