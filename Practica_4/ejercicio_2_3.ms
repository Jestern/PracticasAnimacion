fn interpolacionLineal t frames CP0 CP1= 
(
	V1 = (CP1-CP0)
	POS = CP0 + ((normalize V1)*(((length V1)/frames)*t))
	return POS
)

fn interpolacionCuadratica t frames CP0 CP1 CP2=
(
	Q0 = interpolacionLineal t frames CP0 CP1
	Q1 = interpolacionLineal t frames CP1 CP2
	POS = interpolacionLineal t frames Q0 Q1
	return POS
)

fn animacionCuadratica Obj CP0 CP1 CP2= 
(

	animate on
	(
		for t in 0 to 100 by 1 do
		(
			at time t
			(
				Obj.pos = interpolacionCuadratica t 100 CP0 CP1 CP2
			)
			
		)
	)
)


animacionCuadratica $Sphere001  $Dummy001.pos $Dummy002.pos $Dummy003.pos