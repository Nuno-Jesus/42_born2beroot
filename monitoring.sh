#! The system's own architecture
arch=$(uname -a)

#! The number of processor that actually exist physically
phyproc=$(grep "physical id" /proc/cpuinfo | sort -u | wc -l)

#! The number of total cores among the physical CPU's
virtproc=$(grep -c processor /proc/cpuinfo)

#! Used RAM (in MB)
ramusage=$(free -m | grep Mem | awk '{printf("%d/%d MB (%.2f%%)", $3, $2, $3/$2 * 100)}')

#! Used Disk space (in MB/GB)
diskusage=$(df -Bm | grep "LVM" | awk '{used += $3} {total += $2} END {printf("%dMB/%dGB (%.2f%%)", used, total/1024, used/total * 100)}')

#! CPU load
cpuload=$(top -n1 | grep "%Cpu" | awk '{printf("%.1f%%", $2)}')

#! Last boot
lastboot=$(who | awk '{print $3, $4}')

#! LVM use
lvm=$(lsblk | grep -c 'lvm' | awk '{if ($1 > 0) {print "Yes"} else {print "No"}}')

#! Number of TCP connections
tcp=$(ss -t | grep -c ESTAB | awk '{print $1 ESTABLISHED}')

#! User log
log=$(who | awk '{print $1}' | sort -u | wc -l)

#! Newtork
ip=$(hostname -I)
mac=$(ip link | grep ether | awk '{printf("(%s)", $2)}')

#! Sudo 
sudo=$(cat /var/log/sudo/sudo.log | grep -c COMMAND)
wall "
	#Architecture: $arch
	#Physical CPUs: $phyproc
	#Virtual CPUs: $virtproc
	#RAM usage: $ramusage
	#Disk Usage: $diskusage
	#CPU load: $cpuload
	#Last boot: $lastboot
	#LVM use: $lvm
	#TCP connections: $tcp
	#User log: $log
	#Network: $ip $mac
	#Sudo: $sudo
"