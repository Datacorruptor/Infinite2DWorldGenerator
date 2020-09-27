extends Node

var tile
onready var cam = get_node("Flutters")
onready var map = get_node("TileMap")
onready var text = get_node("Flutters/Camera2D/Coords")

var deb=false

onready var dir = {} 

var ChunkSize =16
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	print(dir.get("2",0))
	_setarLadrilhos()
	pass
	
func _setarLadrilhos():
	randomize()
	genChunk(0,0)
	for i in range(-3,4):
		for j in range(-3,4):
			genChunk(i*ChunkSize,j*ChunkSize)
	pass

func _process(delta):
	var cmm = map.world_to_map(cam.position)
	var camx = int(cmm.x)
	var camy = int(cmm.y)
	if Input.is_action_just_pressed("Debug"):
		deb=!deb
	if deb:
		text.text = "("+str(camx)+","+str(camy)+")"
	else:
		text.text=""
	checkChunk(camx,camy)
	
	if Input.is_action_just_pressed("Destroy"):
		var destroyRange=1
		for i in range(-destroyRange,destroyRange+1):
			for j in range(-destroyRange,destroyRange+1):
				if(abs(i)+abs(j)<=destroyRange) and map.get_cell(camx+i,camy+j) < 13:
					map.set_cell(camx+i,camy+j,24)
					dir[str(camx)+","+str(camy)]=1
	
func gen(x,y,type):
	tile = randi()% 7 +13
	
	match type:
		1:
			if randi()%100 > 60:
				tile = 0
			if randi()%10000 > 9995:
				tile = 4
			if randi()%10000000 > 9999995:
				tile = 12
		2:	
			if randi()%100 > 95:
				tile = 0
			if randi()%10000 > 9805:
				tile = 4
			if randi()%10000000 > 9999005:
				tile = 12
		3:	
			if randi()%100 > 80:
				tile = 24
			if randi()%100 > 85:
				tile = 20
			if randi()%100 > 93:
				tile = 21
			if randi()%100 > 95:
				tile = 22
			if randi()%100 > 98:
				tile = 23
			if randi()%10000000 > 9985666:
				tile = 12
	if dir.get(str(x)+","+str(y),0)==1:
		tile=24
	
	map.set_cell(x,y,tile)	
	
	
func genChunk(x,y):
	var xS = x - ((x%ChunkSize)+ChunkSize)%ChunkSize
	var yS = y - ((y%ChunkSize)+ChunkSize)%ChunkSize
	var type=1
	seed(xS*1234567+yS*746351)
	for i in range (xS,xS+ChunkSize):
		for j in range (yS,yS+ChunkSize):
			type=1
			if sqrt(i*i+j*j) > 200:
				type=2
			if sqrt(pow(i-666,2)+pow(j-666,2)) < 60:
				type=3
			gen(i,j,type)

func delChunk(x,y):
	var xS = x - ((x%ChunkSize)+ChunkSize)%ChunkSize
	var yS = y - ((y%ChunkSize)+ChunkSize)%ChunkSize
	for i in range (xS,xS+ChunkSize):
		for j in range (yS,yS+ChunkSize):
			map.set_cell(i,j,-1)

func checkChunk(camx,camy):
	var dist = int(ChunkSize)
	for i in range(-2,3):
		for j in range(-2,3):
			if map.get_cell(camx + i*dist, camy + j*dist) == -1 and (i==-2 or i==2 or j==-2 or j==2 or (j==0 and i==0)): 
				genChunk(camx + i*dist, camy + j*dist)
	checkUnload(camx,camy)
	

func checkUnload(camx,camy):
	var dist = int(ChunkSize)
	for i in range(-5,6):
		for j in range(-5,6):
			if map.get_cell(camx + i*dist, camy + j*dist) != -1  and (i==-5 or i==5 or j==-5 or j==5): 
				delChunk(camx + i*dist, camy + j*dist)
