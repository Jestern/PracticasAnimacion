Function Lineal Traveler CP1  CP2 Inicio Fin   =
(
	VectorSalto =CP2-CP1
	
	animate on
	(
		at time 0
		(
			Traveler.pos=CP1
		)
		
		for t in Inicio to Fin by 1 do
		(
			at time t
			(
				Traveler.pos = CP1 + ((normalize VectorSalto)*(((length VectorSalto)/(Fin-Inicio))*(t-Inicio)))
			)
		)
		
	)
)

rollout Salto "Salto"
(
	label EActor "Actor:" 
	pickbutton UI_SelectorActor "Selecciona Actor"
	label EP1 "P1:" 
	pickbutton UI_SelectorP1 "Selecciona P1"
	label EP2 "P2:" 
	pickbutton UI_SelectorP2 "Selecciona P2"
	
	spinner UI_IF "Comienzo" range:[0,1000,0] type:#Integer
	spinner UI_FF "Duracion" range:[5,100,20] type:#Integer
	button UI_CrearSalto "Crear"
	
	on UI_SelectorActor picked obj do
	(
		global Traveler = obj
		UI_SelectorActor.text = obj.name
	)
	on UI_SelectorP1 picked obj do
	(
		global P1 = obj
		UI_SelectorP1.text = obj.name
	)
	on UI_SelectorP2 picked obj do
	(
		global P2 = obj
		UI_SelectorP2.text = obj.name
	)
	
	on UI_CrearSalto pressed do
	(
		  if Traveler!= undefined do
		  (
			  deletekeys Traveler
			  Traveler.dir = [0,0,1]
				  
   	          Lineal Traveler P1.pos  P2.pos UI_IF.value (UI_IF.value+UI_FF.value)  
			  Traveler.showtrajectory = on
		  )
    )
)

createDialog Salto
    