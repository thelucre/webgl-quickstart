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
			@renderer.setClearColor 0x38a48a

			@light = new THREE.DirectionalLight( 0xffffff, 1 )
			@light.position.set -2,4,2
			@light.castShadow = true

			@light2 = new THREE.DirectionalLight( 0xffffff, 1 )
			@light2.position.set 0,-4,0
			@light2.castShadow = true

			@ambient = new THREE.AmbientLight( 0x404040 )
			@ambient.castShadow = true

			@scene.add @light
			# @scene.add @light2
			@scene.add @ambient


			@manager = new THREE.LoadingManager()

			@mower = new OBJModel @manager, @scene, 'models/LawnMower.dae'

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
			@mower.tween()
			return

		###
		Kill all your scene objects
		###
		onDeactivate: () ->
			delete @light
			delete @light2
			delete @mower
			return
