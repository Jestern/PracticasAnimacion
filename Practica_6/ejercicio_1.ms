fn RodarPlano Actor Ctrl Srf start end=
(
	
	for t in start to end by 1 do
	(
		set time t
			
		dir = [0, 0, -1]
		
		-- Creamos el rayo para intersecar
		rayo = ray Ctrl.pos dir
		colision = IntersectRay Srf rayo
		up_diff  = (normalize(colision.dir)*Actor.radius*Actor.scale.x)
		
		pos = colision.pos + up_diff
		
		diff = normalize(pos - Actor.pos)
		dist = distance Actor.pos pos
		rot_dir = [diff.y, -diff.x, diff.y]
		
		angulo = 360*(Length(pos - Actor.pos))/((2*Actor.radius)*pi)
		Quaternion = quat angulo rot_dir
		RotEuler = QuatToEuler Quaternion
		
		animate on
		(
			at time t
			(
				Actor.pos = pos
				rotate Actor RotEuler
			)
		)
	)
)
rollout roll "Rodar"
(
	label EControlador "Controlador:" 
	pickbutton UI_SelectorControlador "Selecciona Controlador"
	
	label EActor "Actor:" 
	pickbutton UI_SelectorActor "Selecciona Actor"
	
	label EPlano "Plano:" 
	pickbutton UI_SelectorPlano "Selecciona Plano"
	
	
	spinner UI_IF "Comienzo" range:[0,1000,0] type:#Integer
	spinner UI_FF "Duracion" range:[5,100,100] type:#Integer
	button UI_CrearRoll "Crear"
	
	on UI_SelectorControlador picked obj do
	(
		global Controlador = obj
		UI_SelectorControlador.text = obj.name
	)
	on UI_SelectorActor picked obj do
	(
		global Actor = obj
		UI_SelectorActor.text = obj.name
	)
	on UI_SelectorPlano picked obj do
	(
		global Plano = obj
		UI_SelectorPlano.text = obj.name
	)
	
	on UI_CrearRoll pressed do
	(
		  if Actor != undefined and Controlador != undefined and Plano != undefined do
		  (
			  deletekeys Actor
				  
   	          RodarPlano Actor Controlador Plano UI_IF.value (UI_IF.value+UI_FF.value)
			  Actor.showtrajectory = on
		  )
    )
)

createDialog roll