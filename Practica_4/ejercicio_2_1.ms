fn createMovement start end Obj_angle Obj_color Obj_radius Obj_center=
(
	ball = sphere radius:obj_radius wireColor:Obj_color
	ball.pos = ball.pos + Obj_center
	
	animate on
	(
		at time start
		(
			ball.rotation = ball.rotation + eulerToQuat(eulerAngles 0 0 0)
		)
		at time end
		(
			ball.rotation = ball.rotation + eulerToQuat(Obj_angle)
		)
	)
)

angle1 = eulerAngles 0 90 0
createMovement 0 20 angle1 white 10 [20, 0, 0]
createMovement 20 40 angle1 red 10 [40, 0, 0]
createMovement 40 60 angle1 green 10 [60, 0, 0]
createMovement 60 80 angle1 blue 10 [80, 0, 0]