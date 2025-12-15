// server.js
const WebSocket = require('ws');
const port = 9000; // ¡Asegúrate de que este puerto coincida con el de Godot!

// Crea un nuevo servidor WebSocket
const wss = new WebSocket.Server({ port: port }, () => {
    console.log(`🚀 Servidor WebSocket iniciado en el puerto: ${port}`);
    console.log("¡Listo para aceptar conexiones de Godot!");
});

// Almacena todas las conexiones activas
const clients = new Set();

// Manejar nuevas conexiones
wss.on('connection', function connection(ws, req) {
    // Registra la nueva conexión
    clients.add(ws);
    const clientIp = req.socket.remoteAddress;
    console.log(`➕ Nuevo cliente conectado. IP: ${clientIp}. Clientes totales: ${clients.size}`);

    // Manejar mensajes recibidos del cliente
    ws.on('message', function incoming(message) {
        // En un juego real, aquí es donde procesarías la lógica (movimiento, disparos, etc.)
        // Para este ejemplo, simplemente reenviaremos el mensaje a TODOS los demás clientes (broadcast)
        
        console.log(`📩 Mensaje recibido: ${message.toString()}`);

        // Reenviar a todos los demás clientes (simulación de relay/broadcast)
        clients.forEach(client => {
            if (client !== ws && client.readyState === WebSocket.OPEN) {
                client.send(message);
            }
        });
    });

    // Manejar cierre de conexión
    ws.on('close', () => {
        clients.delete(ws);
        console.log(`➖ Cliente desconectado. Clientes restantes: ${clients.size}`);
    });

    // Manejar errores
    ws.on('error', (error) => {
        console.error('❌ Error en el cliente:', error.message);
    });
});