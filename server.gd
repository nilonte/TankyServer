# server.gd
extends Node

func _ready():
	print("🟢 Iniciando servidor Godot Headless")

	var peer := WebSocketMultiplayerPeer.new()
	var port := 9000

	var err := peer.create_server(port)
	if err != OK:
		print("❌ Error al crear servidor WebSocket:", err)
		get_tree().quit()
		return

	multiplayer.multiplayer_peer = peer

	multiplayer.peer_connected.connect(_on_peer_connected)
	multiplayer.peer_disconnected.connect(_on_peer_disconnected)

	print("🚀 Servidor escuchando en puerto", port)

func _on_peer_connected(id):
	print("➕ Cliente conectado. Peer ID:", id)

func _on_peer_disconnected(id):
	print("➖ Cliente desconectado. Peer ID:", id)
