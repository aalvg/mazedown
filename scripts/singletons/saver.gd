extends Node

var bestmoedas  = 0 setget set_bestmoedas
var itens  =  {}
var controles = {}
const filepath = "user://moedas.dat"
var salvar_moedas = false
var score_temp = 0
var estrelas_por_fase:Dictionary = {}
var dados

func _ready():
	load_moedas()

func load_moedas():
	var file = File.new()
	if not file.file_exists(filepath): return
	file.open(filepath, File.READ)
	#file.open(filepath, File.WRITE)
	dados = file.get_var()
	if dados != null:
		# Coloca os dados
		bestmoedas = dados["moedas_b"]
		estrelas_por_fase = dados["estrelas_dic"]
		itens = dados["itens"]
		controles = dados ["controles"]
	file.close()

func save_bestmoedas():
	var file = File.new()
	file.open(filepath, File.WRITE)
	#file.open(filepath, File.WRITE)
	# Coloca os dados no dictionary
	dados = {}
	dados["moedas_b"] = bestmoedas
	dados["estrelas_dic"] = estrelas_por_fase 
	dados["itens"] = itens
	dados["controles"] = controles
	file.store_var(dados)
	file.close()
	
func set_bestmoedas(value):
	bestmoedas = value
	save_bestmoedas()
