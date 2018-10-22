#!/usr/bin/env bash

# Activamos BFQ I/O Sched para todos los disco duros en el sistema

echo "Aplicando bfq para todos los disco duros..."
echo "bfq" > /sys/block/sda/queue/scheduler
echo "bfq" > /sys/block/sdb/queue/scheduler
echo "BFQ Activado!"

echo "Activando performance para el intel_pstate"
echo "performance" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo "performance" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
echo "performance" > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
echo "performance" > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor

