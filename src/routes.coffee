module.exports =
	'/':
		component: require './template/component.coffee'
		label: 'Template (3D Text)'

	'/cubes-and-deer':
		component: require './cubes-and-deer/component.coffee'
		label: 'Cubes, Deer, Tweens'

	'/cube-grid':
		component: require './cube-grid/component.coffee'
		label: 'Cube Grid'


	'/json-data':
		component: require './json-data/component.coffee'
		label: 'JSON Data Slider'


	'/lawn-mower':
		component: require './lawn-mower/component.coffee'
		label: 'Lawn Mower OBJ'
