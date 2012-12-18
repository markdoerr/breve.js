class breve.Examples.BraitenbergVehicle extends breve.Agent
  setup: (attrs) ->
    super(attrs)
    @set("location", breve.vector([250,250]))
    @set("radius", 80)
    @set("image", "html/images/car.png")
    
    @leftSensor =  @addChild(new breve.Examples.BraitenbergSensor(@engine, {location: [65, -25]}))
    @rightSensor = @addChild(new breve.Examples.BraitenbergSensor(@engine, {location: [65,  25]}))

  step: (step) ->
    super(step)
    
    left = right = 0
    
    _.map(@engine.all(breve.Examples.BraitenbergLight), (light) =>
      left  += 1.0/Math.pow(@leftSensor.distanceTo(light),2)  if Math.abs(@leftSensor.angleTo(light)) < 1.4
      right += 1.0/Math.pow(@rightSensor.distanceTo(light),2) if Math.abs(@rightSensor.angleTo(light)) < 1.4
    )

    @activateSensors(step, left, right)
    
  activateSensors: (step, left, right) ->
    @set("heading", @get('heading') + step * 300 * (right - left))
    @set("velocity", breve.vector([step * 400000 * Math.min(left, right),0]).rotate(@get('heading'), [0,0]))

class breve.Examples.BraitenbergSensor extends breve.Agent
  setup: (attrs) ->
    super(attrs)
    @set("radius", 6)
    @set("color", [1,1,1,1])
    
class breve.Examples.BraitenbergLight extends breve.Agent
  setup: (attrs) ->
    super(attrs)
    @set("radius", 8)
    @set("color", [1,1,.2,1])
