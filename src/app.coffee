# import global styles (to force a compile)
require 'style.styl'
require './transitions.styl'

Vue.use require 'vue-resource'
Vue.use VueRouter

Vue.config.debug = true

App = Vue.extend
	components:
		menu: require './menu/component.coffee'

	ready: () ->
		# Leaving this on boot to inspect the THREEjs lib at runtime
		console.log THREE
		return

router = new VueRouter

router.map require './routes.coffee'

router.start App, '#app'
