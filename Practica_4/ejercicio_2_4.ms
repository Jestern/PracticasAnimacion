fn interpolacionCubica t frames CP0 CP1 CP2 CP3= 
(
	normalized_t = t  / (frames *1.0)
	cubic_t = normalized_t*normalized_t*normalized_t
	quadratic_t = normalized_t*normalized_t
	
	mul_cp0 = -cubic_t + 3 * quadratic_t - 3 * normalized_t + 1
	mul_cp1 = 3 * cubic_t - 6 * quadratic_t + 3 * normalized_t
	mul_cp2 = - 3 * cubic_t + 3 * quadratic_t
	
	POS = CP0 * mul_cp0 + CP1 * mul_cp1 + CP2 * mul_cp2 + cubic_t * CP3
	return POS
)

fn animacionCubica Obj CP0 CP1 CP2 CP3= 
(

	animate on
	(
		for t in 0 to 100 by 1 do
		(
			at time t
			(
				Obj.pos = interpolacionCubica t 100 CP0 CP1 CP2 CP3
			)
			
		)
	)
)


animacionCubica $Sphere001 $Dummy001.pos $Dummy002.pos $Dummy003.pos $Dummy004.pos