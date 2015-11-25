###
The marquee
###

# Deps
CustomCube = require './CustomCube.coffee'
OBJModel = require './OBJModel.coffee'

# Component definition
module.exports =
	template: require './template.haml'

	mixins: [ require '../mixins/webgl-base.coffee' ]

	methods:
		###
		Called after the webgl-base scene is created for you.
		You can override the `setup()` method in this component to build a custom
		scene, camera, and renderer.
		###
		stageReady: () ->
			@cubes = []

			# Make 10 cubes
			for index in [0...9]
				@cubes.push new CustomCube @scene,
					position: new THREE.Vector3 index - 4.5, 0, 0
					scale: new THREE.Vector3 0.5, 2, 0.5
					wireframe: false

			@light = new THREE.DirectionalLight( 0xffffff, 2 )
			@light.position.set 0,4,3
			@light.castShadow = true

			@light2 = new THREE.DirectionalLight( 0xffffff, 2 )
			@light2.position.set -4,-4,-3
			@light2.castShadow = true

			@scene.add @light
			@scene.add @light2

			@manager = new THREE.LoadingManager()

			@deer = new OBJModel @manager, @scene, 'models/Deer.obj'

			# kick off the render loop
			@render()
			return

		###
		Hook to update your scene objects per loop. See `webgl-base.render()`
		for where this is called. It will request a new loop,
		render the scene, or update TWEENjs.
		###
		onRender: (time)->
			_.each @cubes, (cube) ->
				cube.update()
			return

		###
		Kill all your scene objects
		###
		onDeactivate: () ->
			delete @text
			return

		###

		###
		onClick: () ->
			_.each @cubes, (cube) ->
				cube.tween()

			@deer.tween()
			return

		###

		###
		onDeactivate: () ->
			delete @cubes
			delete @light
			delete @light2
			delete @deer
			return
