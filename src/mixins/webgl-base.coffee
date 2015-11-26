module.exports =
	ready: () ->
		@setup()
		@stageReady()
		return

	route:
		deactivate: () ->
			$(window).off 'resize', @onResize

			# destroy the threejs scene
			cancelAnimationFrame @animationID
			@scene = null
			@projector = null
			@camera = null
			@controls = null

			@onDeactivate()
			return

		activate: () ->
			$(window).on 'resize', @onResize
			@onActivate()
			return

	methods:
		setup: () ->
			# Aspect of the renderer is required to properly display the scene
			# This should be recalculated on a resize callback
			@width = @$els.canvas.clientWidth
			@height = @$els.canvas.clientHeight
			@aspect = @width / @height

			# Like Flash's stage, a scene hold a heirarchy of display objects
			@scene = new THREE.Scene()

			# Camera determines what will render in 3D space
			@camera = new THREE.PerspectiveCamera 20, @aspect, 0.1, 1000
			@camera.position.set 0,0,30

			@renderer = new THREE.WebGLRenderer
				alpha: true
				antialias: true
				canvas: @$els.canvas

			@renderer.setSize @width, @height

			return

		###
		The Loop
		###
		render: (time) ->
			# Keeps animationg loop running, should be the first line in your render loop
			@animationID = requestAnimationFrame @render

			@onRender(time)

			# Updates the canvas output image
			@renderer.render @scene, @camera

			# Updates TWEENjs easing functions globally
			TWEEN.update time
			return

		###
		Render hook called automatically. (OVERRIDE ME!)
		###
		onRender: (time) ->
			return

		###
		Scene is created, add your objects. (OVERRIDE ME!)
		###
		stageReady: () ->
			console.log 'mixin stage ready. override me if you wanna add stuff to scene'
			return

		###
		Hook to unlaod anythign custom from the component, such as event listeners. (OVERRIDE ME!)
		###
		onDeactivate: () ->
			return

		###
		Hook to add custom from the component, such as event listeners. (OVERRIDE ME!)
		###
		onActivate: () ->
			return

		onResize: (e) ->
			@width = @$els.canvas.clientWidth
			@height = @$els.canvas.clientHeight
			@aspect = @width / @height

			@camera.aspect = @aspect
			@camera.updateProjectionMatrix()
			@renderer.setSize @width, @height
			return
