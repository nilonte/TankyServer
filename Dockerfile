FROM ubuntu22.04

# Evitar prompts interactivos
ENV DEBIAN_FRONTEND=noninteractive

# Instalar dependencias mínimas (librerías necesarias para ejecutar Godot en Linux)
RUN apt-get update && apt-get install -y 
    ca-certificates 
    libstdc++6 
    libgcc-s1 
    && rm -rf varlibaptlists

WORKDIR app

# Copiar el binario y el pack (Ajustado a tus nombres TankServerMUC)
COPY TankServerMUC.x86_64 .
COPY TankServerMUC.pck .

# Permisos de ejecución
RUN chmod +x TankServerMUC.x86_64

# Render expone este puerto por variable (8080 es el estándar)
EXPOSE 8080

# Arrancar el servidor Godot con flags de modo headless
CMD [.TankServerMUC.x86_64, --headless, --main-pack, TankServerMUC.pck]