CustomText = require './CustomText.coffee'

class MessagePane
	constructor: (@scene, options) ->
		@index = options.index
		@size = options.size

		color = 0x0d6480
		if options.data.color?
			color = parseInt(options.data.color)

		@group = new THREE.Group()

		# Setup pane geometry
		@geometry = new THREE.CubeGeometry 6, 2.5, 0.25
		@material = new THREE.MeshLambertMaterial
			color: color

		@view = new THREE.Mesh @geometry, @material

		@group.add @view
		@group.rotation.set 0, Math.PI/2, 0

		@texts = _.map options.data.message, (msg, i) =>
			new CustomText @group,
				position: new THREE.Vector3 -2.6, 0.6 - i * 0.5, 0.1
				message: msg

		@scene.add @group

		return @

	animate: (activeIndex) =>
		if activeIndex == @index
			@animateActive()
		else
			@animateInactive(activeIndex)
		return

	animateActive: () =>
		from =
			rx: @group.rotation.x
			ry: @group.rotation.y
			rz: @group.rotation.z
			px: @group.position.x
			py: @group.position.y
			pz: @group.position.z

		to =
			rx: -Math.PI/16
			ry: Math.PI/8
			rz: Math.PI/32
			px: 0
			py: 0
			pz: 0

		_view = @group

		tween = new TWEEN.Tween(from)
			.to to, 700
			.onUpdate () ->
				_view.position.set @px, @py, @pz
				_view.rotation.set @rx, @ry, @rz
				return
			.easing TWEEN.Easing.Quadratic.InOut
			# .delay()
			.start()
		return

	animateInactive: (activeIndex) =>
		from =
			rx: @group.rotation.x
			ry: @group.rotation.y
			rz: @group.rotation.z
			px: @group.position.x
			py: @group.position.y
			pz: @group.position.z
			delay: @index * 60

		to =
			rx: 0
			ry: Math.PI/2
			rz: 0
			px: -3 - @size * 0.4 + @index * 0.4
			py: 0
			pz: 0

		if @index > activeIndex
				to.px = 3 + @index * 0.4
				from.delay = (@size - @index) * 60

		_view = @group

		tween = new TWEEN.Tween(from)
			.to to, 700
			.onUpdate () ->
				_view.position.set @px, @py, @pz
				_view.rotation.set @rx, @ry, @rz
				return
			.easing TWEEN.Easing.Quadratic.InOut
			.delay(from.delay)
			.start()
		return

module.exports = MessagePane
