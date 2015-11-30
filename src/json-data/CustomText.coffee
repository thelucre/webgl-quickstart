require '../utils/FontUtils.js'
require './minecraftia.typeface.js'
require '../utils/TextGeometry.js'

###
Standard coffee class will be our 3D 'View'
###
class CustomText
	constructor: (@scene, options) ->
		options = options || {}
		options.position = options.position || new THREE.Vector3(0,0,0)
		options.scale = options.scale || new THREE.Vector3(1,1,1)
		options.message = options.message || 'This is a message from god.'
		text3d = new THREE.TextGeometry( options.message, {
			size: 0.2,
			height: 0.1,  # actually, depth
			curveSegments: 1,
			font: "Minecraftia"

		});

		@material = new THREE.MeshFaceMaterial [
			new THREE.MeshLambertMaterial( { color: 0xeeeeee, overdraw: 0.5 } ),
			new THREE.MeshLambertMaterial( { color: 0x000000, overdraw: 0.5 } )
		]

		@view = new THREE.Mesh( text3d, @material );

		@view.position.set options.position.x, options.position.y, options.position.z
		@view.scale.set options.scale.x, options.scale.y, options.scale.z

		@view.rotation.x = 0;
		@view.rotation.y = Math.PI * 2;

		@scene.add @view

		return @

	# Remeber the fat arrow is needed for standard Coffee class bidning to `this`
	update: (time) =>
		#  simple oscillation
		# @view.scale.set 1,1,(1 + Math.sin(time/1000) * (Math.PI))
		# @view.rotation.x = Math.PI * 2 + (Math.sin(time/2000) * (Math.PI/180))
		return

module.exports = CustomText
