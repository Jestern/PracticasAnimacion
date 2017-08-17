import maya.cmds as cmds

class Point(object):
    __slots__ = ['x', 'y', 'z']

def interpolateValue(pA, pB, pT):
    return ( ( (1 - pT)  * pA) + ( pT * pB ) )

def lerp(pFirst, pSecond, pT):
    punto = Point()
    
    punto.x = interpolateValue(pFirst.x, pSecond.x, pT)
    punto.y = interpolateValue(pFirst.y, pSecond.y, pT)
    punto.z = interpolateValue(pFirst.z, pSecond.z, pT)
    
    return punto
    
def getPositions(pPoints):
    positions = []
    
    for point in pPoints:
        p = Point()
        p.x = cmds.getAttr("%s.translateX" % point)
        p.y = cmds.getAttr("%s.translateY" % point)
        p.z = cmds.getAttr("%s.translateZ" % point)
        positions.append(p)
    
    return positions

def interpolacionCuadratica(pSelectionList, pStart, pEnd):
    objectName = pSelectionList[0]
    pSelectionList.remove(objectName)
    
    positions = getPositions(pSelectionList)
    
    nEnd = pEnd - pStart - 1
    
    cmds.cutKey( objectName, time=(pStart, pEnd), attribute='translateX' )
    cmds.cutKey( objectName, time=(pStart, pEnd), attribute='translateY' )
    cmds.cutKey( objectName, time=(pStart, pEnd), attribute='translateZ' )
    
    for t in range( 0, nEnd ):
        fraccion_t =t/(nEnd * 1.0)
        
        p1 = lerp(positions[0], positions[1], fraccion_t)
        p2 = lerp(positions[1], positions[2], fraccion_t)
        
        p = lerp(p1, p2, fraccion_t)
        
        nT = pStart + t
        
        cmds.setKeyframe( objectName, time=(nT), attribute='translateX', value=p.x, inTangentType='linear', outTangentType='linear' )
        cmds.setKeyframe( objectName, time=(nT), attribute='translateY', value=p.y, inTangentType='linear', outTangentType='linear' )
        cmds.setKeyframe( objectName, time=(nT), attribute='translateZ', value=p.z, inTangentType='linear', outTangentType='linear' )

selected = cmds.ls(orderedSelection=True)

if len(selected) == 4:
    interpolacionCuadratica(selected, 1, 300)
else :
    print 'Para usar el script hace falta seleccionar 4 objetos, primero el objeto que quieres que se mueva.'
