Function interpolacionLineal t frames CP0 CP1= 
(
	V1 = (CP1-CP0)
	POS = CP0 + ((normalize V1)*(((length V1)/frames)*t))
	return POS
)

Function interpolacionCuadratica t frames CP0 CP1 CP2=
(
	Q0 = interpolacionLineal t frames CP0 CP1
	Q1 = interpolacionLineal t frames CP1 CP2
	POS = interpolacionLineal t frames Q0 Q1
	return POS
)

Function animacionSalto inicio fin Actor Objs=
(
	frames = fin - inicio
	
	animate on
	(
		for i in 1 to (Objs.count - 1) by 1 do
		(
			obj1 = Objs[i]
			obj2 = Objs[i+1]
			intermedio = (obj1.pos + obj2.pos) / 2.0
			intermedio.z = (distance obj1 obj2)
			
			half_frames  = frames / 2
			at time inicio
			(
				Actor.scale = [1, 1.4, 0.7]
			)
			
			for t in inicio to fin by 1 do
			(
				at time t
				(
					normalized_t = t - inicio
					
					Actor.pos = interpolacionCuadratica normalized_t frames obj1.pos intermedio obj2.pos
					case of
					(
						(t == inicio + 2): Actor.scale = [0.6, 1, 1.7]
						
						(normalized_t == half_frames): Actor.scale = [1, 1, 1]
						
						(t == fin - 1): Actor.scale = [0.9, 1, 1.1]
						
						(t == fin): Actor.scale = [1, 1.4, 0.7]
						
					)
				)
			)
			
			inicio = inicio + frames
			fin = fin + frames
		)
	)
	
)

global objs = #()

rollout Salto "Salto"
(
	label EActor "Actor:" 
	pickbutton UI_SelectorActor "Selecciona Actor"
	
	label EPuntos "Añadir un punto a saltar:" 
	pickbutton UI_SelectorP "Añadir Punto"
	
	listbox listObjs "Puntos (doble click elimina)"
	button UI_Arriba "Mover arriba"
	button UI_Abajo "Mover abajo"
	
	
	spinner UI_IF "Comienzo" range:[0,1000,0] type:#Integer
	spinner UI_FF "Duracion salto" range:[5,100,20] type:#Integer
	button UI_CrearSalto "Crear"
	
	on UI_SelectorActor picked obj do
	(
		global Actor = obj
		UI_SelectorActor.text = obj.name
	)
	on UI_SelectorP picked obj do
	(
		list = listObjs.items
		append list obj.name
		append objs obj
		listObjs.items = list
	)
	on listObjs doubleClicked item do
	(
		list = listObjs.items
		deleteItem list item
		deleteItem objs item
		listObjs.items = list
	)
	
	on UI_Arriba pressed do
	(
		item = listObjs.selection
		
		if(item > 1) then
		(
			next = item - 1
			list = listObjs.items
			
			tmp = list[item]
			list[item] = list[next]
			list[next] = tmp
			
			obj_tmp = objs[item]
			objs[item] = objs[next]
			objs[next] = obj_tmp
			
			listObjs.items = list
		)
	)
	
	on UI_Abajo pressed do
	(
		item = listObjs.selection
		
		if(item > 0 and item < listObjs.items.count) then
		(
			next = item + 1
			list = listObjs.items
			
			tmp = list[item]
			list[item] = list[next]
			list[next] = tmp
			
			obj_tmp = objs[item]
			objs[item] = objs[next]
			objs[next] = obj_tmp
			
			listObjs.items = list
		)
	)
	
	on UI_CrearSalto pressed do
	(
		  if Actor != undefined and objs.count > 1 do
		  (
			  deletekeys Actor
			  Actor.dir = [0,0,1]
				  
   	          animacionSalto UI_IF.value (UI_IF.value+UI_FF.value) Actor objs
			  Actor.showtrajectory = on
		  )
    )
)

createDialog Salto