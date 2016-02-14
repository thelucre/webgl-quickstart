require '../utils/OBJLoader.js'

###
Loads a typical OBJ file.
Filename should be relative without leading '/'
###
class OBJModel
	constructor: (@manager, @scene, @file) ->
		@loader = new THREE.OBJLoader @manager
		@loader.load (window.location.pathname + @file), @onLoad
		return

	onLoad: (object) =>
		@view = object

		@material = new THREE.MeshPhongMaterial
			side:			THREE.DoubleSide
			shading:  THREE.SmoothShading
			# color: 		0x550055
			# emissive: 0x555500

		object.traverse (child) =>
			if child instanceof THREE.Mesh
				child.material = @material
				child.geometry.computeFaceNormals()
				child.geometry.computeVertexNormals(true)

		# @view.material = @material
		# @geometry = @view.geometry

		@view.rotation.set 0,-Math.PI/2 ,0
		scale = 1
		@view.scale.set scale, scale, scale
		@view.position.set 0,-2,0

		@view.needsUpdate = true
		@scene.add @view

		return

	tween: () ->
		from =
			sx: @view.scale.x
			sy: @view.scale.y
			sz: @view.scale.z
			ry: @view.rotation.y
			r: @material.emissive.r
			g: @material.emissive.g
			b: @material.emissive.b


		to =
			sx: @view.scale.x
			sy: @view.scale.y
			sz: @view.scale.z
			ry: @view.rotation.y + Math.PI/2
			# rz: @view.rotation.z + Math.PI
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
				# _material.emissive = new THREE.Color @r, @g, @b
				return
			.easing TWEEN.Easing.Back.InOut
			.delay(Math.random() * 220)
			.start()
		return

module.exports = OBJModel
