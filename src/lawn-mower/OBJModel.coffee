require '../utils/ColladaLoader.js'

###
Loads a typical OBJ file.
Filename should be relative without leading '/'
###
class OBJModel
	constructor: (@manager, @scene, @file) ->
		@loader = new THREE.ColladaLoader()
		@loader.load (window.location.pathname + @file), @onLoad
		return

	onLoad: (collada) =>
		@view = collada.scene
		#
		# @material = new THREE.MeshPhongMaterial
		# 	side:			THREE.DoubleSide
		# 	shading:  THREE.SmoothShading
		# 	# color: 		0x550055
		# 	# emissive: 0x555500
		#
		collada.scene.traverse (child) =>
			if child instanceof THREE.Mesh

				child.geometry.computeFaceNormals()
				# child.geometry.computeVertexNormals(true)
				child.geometry.needsUpdate = true

				if child.material instanceof THREE.MeshPhongMaterial
					child.material.shininess = 0
				else if child.material instanceof THREE.MultiMaterial
					_.each child.material.materials, (mat) ->
						mat.shininess = 0

		#
		# # @view.material = @material
		# # @geometry = @view.geometry
		#
		@view.rotation.set -Math.PI/2, 0, Math.PI/4
		# scale = 1
		# @view.scale.set scale, scale, scale
		@view.position.set 0,-2,0
		#
		# @view.needsUpdate = true
		@scene.add @view

		return

	tween: () ->
		from =
			sx: @view.scale.x
			sy: @view.scale.y
			sz: @view.scale.z
			ry: @view.rotation.y
			rz: @view.rotation.z
			# r: @material.emissive.r
			# g: @material.emissive.g
			# b: @material.emissive.b


		to =
			sx: @view.scale.x
			sy: @view.scale.y
			sz: @view.scale.z
			# ry: @view.rotation.y + Math.PI/2
			rz: @view.rotation.z + Math.PI/2
			r: Math.random() * 255 / 255
			g: Math.random() * 255 / 255
			b: Math.random() * 255 / 255

		_view = @view
		_material = @material

		tween = new TWEEN.Tween(from)
			.to to, 700
			.onUpdate () ->
				_view.scale.set @sx, @sy, @sz
				_view.rotation.z = @rz
				# _material.emissive = new THREE.Color @r, @g, @b
				return
			.easing TWEEN.Easing.Back.InOut
			.delay(Math.random() * 220)
			.start()
		return

module.exports = OBJModel
