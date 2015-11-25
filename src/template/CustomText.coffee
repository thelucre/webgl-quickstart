require '../utils/FontUtils.js'
require './helvetiker.typeface.js'
require '../utils/TextGeometry.js'

###
Standard coffee class will be our 3D 'View'
###
class CustomText
	constructor: (@scene, options) ->
		options = options || {}
		message = options.message || 'BKWLD'
		text3d = new THREE.TextGeometry( message, {
			size: 1,
			height: 20,  # actualy, depth
			curveSegments: 4,
			font: "helvetiker"

		});

		text3d.computeBoundingBox();
		centerOffset = -0.5 * ( text3d.boundingBox.max.x - text3d.boundingBox.min.x );

		@material = new THREE.MeshFaceMaterial [
			new THREE.MeshBasicMaterial( { color: Math.random() * 0xffffff, overdraw: 0.5 } ),
			new THREE.MeshBasicMaterial( { color: Math.random() * 0xffffff, overdraw: 0.5 } )
		]

		@view = new THREE.Mesh( text3d, @material );

		@view.position.x = centerOffset;
		@view.position.y = -0.5;
		@view.position.z = 0;

		@view.rotation.x = 0;
		@view.rotation.y = Math.PI * 2;

		@scene.add @view

		return @

	# Remeber the fat arrow is needed for standard Coffee class bidning to `this`
	update: (time) =>
		#  simple oscillation
		@view.rotation.y = Math.PI * 2 + (Math.sin(time/1000) * (Math.PI/60))
		@view.rotation.x = Math.PI * 2 + (Math.sin(time/2000) * (Math.PI/180))
		return

module.exports = CustomText
