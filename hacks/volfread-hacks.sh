#!/usr/bin/env bash

################################ I/O SCHED #################################################
# Activamos BFQ I/O Sched para todos los disco duros en el sistema
# Para conocer que I/O sched esta usando solo debe hacer un 
# cat /sys/block/sdX/queue/scheduler en su sistema
# Para HDD es recomendable usar CFQ o BFQ
# Para SSD es recomendable usar mq-deadline o deadline

echo "Aplicando bfq para todos los disco duros..."
echo "bfq" > /sys/block/sda/queue/scheduler
echo "bfq" > /sys/block/sdb/queue/scheduler
echo "BFQ Activado!"

################################# GOVERNOR CPU ##############################################
# Activamos el scaling performance con el driver intel_pstate
# Para activar el scaling en cada CPU debe pasar el comando abajo mencionado para cada CPU

echo "Activando el scaling governor performance para el schedutil"
echo "schedutil" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo "schedutil" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
echo "schedutil" > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
echo "schedutil" > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
echo "Performance scaling governor...Activado!"

