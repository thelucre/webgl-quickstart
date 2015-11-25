require '../utils/OBJLoader.js'

###
Loads a typical OBJ file.
Filename should be relative with leading '/'
###
class OBJModel
	constructor: (@manager, @scene, @file) ->
		@loader = new THREE.OBJLoader @manager
		@loader.load @file, @onLoad
		return

	onLoad: (object) =>
		@view = object.children[0]
		@material = new THREE.MeshPhongMaterial
			color: 0xcccccc
			emissive: 0xffffff
			shading: THREE.FlatShading

		@view.material = @material
		@geometry = @view.geometry

		@view.rotation.set 0,-Math.PI/2 ,0
		scale = 0.01
		@view.scale.set scale, scale, scale
		@view.position.set 0,-2.5,2

		@view.needsUpdate = true
		@scene.add @view

		return

	tween: () ->
		from =
			sx: @view.scale.x
			sy: @view.scale.y
			sz: @view.scale.z
			ry: @view.rotation.y
			r: @material.color.r
			g: @material.color.g
			b: @material.color.b


		to =
			sx: @view.scale.x
			sy: @view.scale.y
			sz: @view.scale.z
			ry: @view.rotation.y + Math.PI
			r: Math.random() * 255 / 255
			g: Math.random() * 255 / 255
			b: Math.random() * 255 / 255

		_view = @view
		_material = @material

		tween = new TWEEN.Tween(from)
			.to to, 700
			.onUpdate () ->
				_view.scale.set @sx, @sy, @sz
				_view.rotation.y = @ry
				_material.color = new THREE.Color @r, @g, @b
				return
			.easing TWEEN.Easing.Back.InOut
			.delay(Math.random() * 220)
			.start()
		return

module.exports = OBJModel
