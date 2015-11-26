###
Standard coffee class will be our 3D 'View'
###
class Cube
	constructor: (@scene, options) ->
		@colors = [
			0xFE4365,
			# 0xFC9D9A,
			0xf1f1f1,
			0xC8C8A9,
			0x83AF9B
		]

		options = options || {}
		options.position = options.position || new THREE.Vector3(0,0,0)
		options.scale = options.scale || new THREE.Vector3(1,1,1)
		options.wireframe = options.wireframe || false

		@geometry = new THREE.CubeGeometry 1,1,1

		_.each @geometry.faces, (face, index) =>
			color = @colors[Math.floor(Math.random() * @colors.length)]
			face.color.setHex color

		@material = new THREE.MeshLambertMaterial
			vertexColors: THREE.FaceColors

		@view = new THREE.Mesh @geometry, @material

		@scene.add @view

		@view.position.set options.position.x, options.position.y, options.position.z
		@view.scale.set options.scale.x, options.scale.y, options.scale.z

		return @

	update: () ->
		@view.rotation.y += 0.01;
		return

	scale: (scale) ->
		@view.scale.set @view.scale.x, scale, @view.scale.z
		return

	tween: (index) ->
		from =
			rx: @view.rotation.x
			color: @material.color.getHex()

		to =
			rx: @view.rotation.x + Math.PI / 2
			color: @colors[Math.floor(Math.random() * @colors.length)]


		_view = @view
		_material = @material

		tween = new TWEEN.Tween(from)
			.to to, 700
			.onUpdate () ->
				_view.rotation.x = @rx
				# _material.color.setHex @color
				return
			.easing TWEEN.Easing.Quadratic.InOut
			.delay(index * 10 + 350)
			.start()


		tween2 = new TWEEN.Tween({scale: 1})
			.to {scale: 0.2}, 350
			.onUpdate () ->
				_view.scale.set @scale, @scale, @scale
				return
			.easing TWEEN.Easing.Exponential.In
			.delay(index * 10)
			.start()

		tween3 = new TWEEN.Tween({scale: 0.2})
			.to {scale: 1}, 650
			.onUpdate () ->
				_view.scale.set @scale, @scale, @scale
				return
			.easing TWEEN.Easing.Exponential.Out
			.delay(1000 + index * 10)
			.start()
		return

module.exports = Cube
