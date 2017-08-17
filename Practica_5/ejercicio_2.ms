-- crea array 10x10 de esferas de radio 1 
for x = 1 to 10 do
for y = 1 to 10 do
Box pos:[x*2,y*2,0] name:("dot_" + x as string + "_" + y as string) \
      lengthsegs:1 widthsegs:1 heightsegs:1 \
      length:1 width:1 height:1 

	
-- crea materiales
mm = multimaterial numsubs:2 name:"Color"
mm.names = #("on", "off")
mm[1].diffuse = mm[1].ambient = white
mm[2].diffuse = mm[2].ambient= red

dots = $dot* as array -- creamos el array de objetos
dots.mat = mm -- asigna el material 

-- añade un modificador para cambiar indice de submaterial a cada objeto
for obj in dots do (
addModifier obj (materialModifier name:"MatMod")
	obj.modifiers[#MatMod].materialID = 2
)
-- crea "helper"
eyes = #()
eyes[1] = cylinder name:"EyeL" radius:0.5 height:5
eyes[2] = cylinder name:"EyeR" radius:0.5 height:5
eyes[1].pos = [4,5,0]
eyes[2].pos = [8,5,0]
eyes.xray = off
eyes.isHidden =off

-- animar "helper"
animationRange = interval 0 100
frameRate = 25
set animate on
set time 40f
eyes.pos.x += 10
eyes.pos.y += 8
set time 68f
eyes.pos.y -= 5
set time 110f
eyes.pos.x -= 10
eyes.pos.y += 8
set animate off
set time off

-- animar materialID's
with animate on (
  for t = 0 to 100 by 5 do 
  (
    sliderTime = t
    for obj in dots do
      if (distance obj.pos eyes[1].pos < 1) Or (distance obj.pos eyes[2].pos < 1) then
      (  
		  obj.modifiers[#MatMod].materialID = 1

	  )
	  else 
	  (
        obj.modifiers[#MatMod].materialID = 2

	  )
  )
)

playAnimation()
--stopAnimation()
