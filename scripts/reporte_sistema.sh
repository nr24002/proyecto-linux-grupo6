#reporte del sistema

echo "=========================================================="
echo "REPORTE DEL SISTEMA - $(date '+%d/%m/%Y %H:%M:%S')"
echo "=========================================================="

#hora y fecha actual
echo "Fecha y hora actual: $(date '+%d/%m/%Y %H:%M:%S')"

#nombre del host del sistema
echo "Nombre del host: $(hostname)"

#numeros de usuarios conectados
echo "Usuarios conectados: $(who | wc -l)"

#espacio libre de disco principal
echo "Espacio libre en disco(/):"
df -h / | awk 'NR==2 {print $4 " libres de " $2}'

#memoria RAM disponible
echo "Memoria RAM disponible:"
free -h | awk '/Mem:/ {print $7 " libres de " $2}'

#numero de contenedores Docker activos
echo "Número de contenedores Docker:"
if which docker &> /dev/null; then
    activos=$(docker ps -q | wc -l)
    echo "Contenedores Docker activos: $activos"
else
	echo "Docker no está instalado en el sistema"
fi

echo "=========================================================="
