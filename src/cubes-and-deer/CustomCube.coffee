###
Standard coffee class will be our 3D 'View'
###
class CustomCube
	constructor: (@scene, options) ->
		options.position = options.position || new THREE.Vector3(0,0,0)
		options.scale = options.scale || new THREE.Vector3(1,1,1)
		options.wireframe = options.wireframe || false

		@geometry = new THREE.CubeGeometry 1,1,1

		@material = new THREE.MeshLambertMaterial
			wireframe: options.wireframe
			color: 0xff0000

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

	tween: () ->
		from =
			sx: 0.5
			sy: @view.scale.y
			sz: 0.5
			rx: @view.rotation.x
			r: @material.color.r
			g: @material.color.g
			b: @material.color.b


		to =
			sx: 0.5
			sy: 0.5 + Math.random() * 4
			sz: 0.5
			rx: @view.rotation.x + Math.PI / 4
			r: Math.random() * 255 / 255
			g: Math.random() * 255 / 255
			b: Math.random() * 255 / 255

		_view = @view
		_material = @material

		tween = new TWEEN.Tween(from)
			.to to, 700
			.onUpdate () ->
				_view.scale.set @sx, @sy, @sz
				_view.rotation.x = @rx
				_material.color = new THREE.Color @r, @g, @b
				return
			.easing TWEEN.Easing.Back.InOut
			.delay(Math.random() * 220)
			.start()
		return

module.exports = CustomCube
