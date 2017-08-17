caja = Box lengthsegs:1 widthsegs:1 heightsegs:1 length:2 width:2 height:2 mapcoords:on pos:[0,0,0] wireColor:red

interpolate_start = 40
interpolate_end = 52

total_frames = interpolate_end - interpolate_start

weight_increment = 1.0 / total_frames
weight = 0.0

animate on
(	
	for t in 0 to 100 by 1 do
	(
		at time t
		(
			case of
			(
				(t <= interpolate_start): caja.pos = $Sphere001.pos
				
				(t <= interpolate_end): 
				(
					normal_t = interpolate_end - t
					caja.pos =$Sphere001.pos + ($Sphere002.pos - $Sphere001.pos) * weight
					weight = weight + weight_increment
				)
				
				default: caja.pos = $Sphere002.pos
			)
		)
	)
)