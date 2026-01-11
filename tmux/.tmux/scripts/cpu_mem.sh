#!/bin/bash
# CPU and Memory usage for macOS (ASCII version)

# CPU usage (averaged)
cpu=$(ps -A -o %cpu | awk '{sum+=$1} END {printf "%.0f", sum/4}')

# Memory usage
mem_info=$(vm_stat 2>/dev/null)
if [[ -n "$mem_info" ]]; then
    pages_free=$(echo "$mem_info" | awk '/Pages free/ {gsub(/\./,"",$3); print $3}')
    pages_active=$(echo "$mem_info" | awk '/Pages active/ {gsub(/\./,"",$3); print $3}')
    pages_inactive=$(echo "$mem_info" | awk '/Pages inactive/ {gsub(/\./,"",$3); print $3}')
    pages_wired=$(echo "$mem_info" | awk '/Pages wired/ {gsub(/\./,"",$4); print $4}')
    pages_compressed=$(echo "$mem_info" | awk '/Pages occupied by compressor/ {gsub(/\./,"",$5); print $5}')
    
    total_mem=$(sysctl -n hw.memsize 2>/dev/null)
    
    used_pages=$((pages_active + pages_wired + pages_compressed))
    mem_percent=$(echo "scale=0; $used_pages * 4096 * 100 / $total_mem" | bc)
else
    mem_percent="?"
fi

# Color for CPU
if [[ $cpu -ge 80 ]]; then
    cpu_color="#[fg=red]"
elif [[ $cpu -ge 50 ]]; then
    cpu_color="#[fg=yellow]"
else
    cpu_color="#[fg=green]"
fi

# Color for memory
if [[ "$mem_percent" != "?" ]] && [[ $mem_percent -ge 80 ]]; then
    mem_color="#[fg=red]"
elif [[ "$mem_percent" != "?" ]] && [[ $mem_percent -ge 50 ]]; then
    mem_color="#[fg=yellow]"
else
    mem_color="#[fg=cyan]"
fi

echo "${cpu_color}CPU ${cpu}%#[fg=white] ${mem_color}MEM ${mem_percent}%#[fg=white]"
