# import global styles (to force a compile)
require 'style.styl'
require './transitions.styl'

Vue = require 'vue'
VueRouter = require 'vue-router'

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
	transitionOnLoad: true

router.map require './routes.coffee'

router.start App, '#app'

#
# app = new Vue
# 	el: '#app'
#
# 	data: {}
#
# 	components:
# 		webgl: require './webgl/component.coffee'
#
# 	ready: () ->
# 		return
