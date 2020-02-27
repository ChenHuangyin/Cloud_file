# Description:
#	This Dockerfile creates a docker image with a running environment for a ubuntu MineCraft Game Server on RPI
# Usage:
#	From this directory, run $ sudo docker build -t RpiMinecraftGameServer:v1.0
# By default, this Dockerfile run as root
# Pull ubuntu:latest
FROM ubuntu:latest
# Get the dependencies for java. Install wget to download server file from Internet.
RUN apt-get update
RUN apt-get install -y default-jre default-jdk wget
# Set up a folder to storage minecraft server files
RUN cd home
RUN mkdir minecraft_server
RUN cd minecraft_server
# Download the official game server jar file
RUN wget https://launcher.mojang.com/v1/objects/bb2b6b1aefcd70dfd1892149ac3a215f6c636b07/server.jar
# Create a bash script file to start the gameserver, and then give executable authority to it
RUN echo "java -jar server.jar" > start.sh
RUN chmod +x start.sh
# Run the server jar to initial the first time server running settings
RUN ./start.sh
# Modify the server setting, make sure it can run in a local network environment
RUN echo "eula=true" > eula.txt
RUN echo $'broadcast-rcon-to-ops=true\n\
view-distance=10 \n\
max-build-height=256 \n\
server-ip=\n\
level-seed=\n\
rcon.port=25575\n\
gamemode=survival\n\
server-port=25565\n\
allow-nether=true\n\
enable-command-block=false\n\
enable-rcon=false\n\
enable-query=false\n\
op-permission-level=4\n\
prevent-proxy-connections=false\n\
generator-settings=\n\
resource-pack=\n\
level-name=world\n\
rcon.password=\n\
player-idle-timeout=0\n\
motd=A Minecraft Server\n\
query.port=25565\n\
force-gamemode=false\n\
hardcore=false\n\
white-list=false\n\
broadcast-console-to-ops=true\n\
pvp=true\n\
spawn-npcs=true\n\
generate-structures=true\n\
spawn-animals=true\n\
snooper-enabled=true\n\
difficulty=easy\n\
function-permission-level=2\n\
network-compression-threshold=256\n\
level-type=default\n\
spawn-monsters=true\n\
max-tick-time=60000\n\
enforce-whitelist=false\n\
use-native-transport=true\n\
max-players=20\n\
resource-pack-sha1=\n\
spawn-protection=16\n\
online-mode=false\n\
allow-flight=false\n\
max-world-size=29999984'\n\
>> server.properties
RUN echo 'Container is ready, run it with the command $ sudo docker run -p 25565:25565 -it RpiMinecraftGameServer:v1.0'
RUN echo 'Then, inside the running container, run: $ cd minecraft_server && ./start.sh'