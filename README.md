# WebGL Quickstart

### Setup
Run:
* `bower install`
* `npm install`
* `webpack -w`
* Setup a MAMP vhost or run `python -m SimpleHTTPServer 8080` in a new terminal window and hit `localhost:8080`

### Adding a demo component
* Duplicate and rename the `src/template` folder
* Register your new demo component in the `routes.coffee` file. This will add it to the routes config and the menu navigation. Example config:
```
'/cube-grid':
	component: require './cube-grid/component.coffee'
	label: 'Cube Grid'
```

### Basic Guide
* The basic THREEjs setup is pulled in through the `webgl-base.coffee` mixin.
* Implement the `stageReady` method to add objects to the scene
* All component implemented `webgl-base` will have access to `@scene`, `@renderer`, and `@camera`
* Override any of the `webgl-base methods` or the `bade.haml` template if you want a full custom scene
* Be sure to properly destroy your scene objects and remove custom event handlers in the `onDeactive` hook.
