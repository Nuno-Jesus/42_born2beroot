#! The system's own architecture
arch=$(uname -a)

#! The number of processor that actually exist physically
phyproc=$(grep "physical id" /proc/cpuinfo | sort -u | wc -l)

#! The number of total cores among the physical CPU's
virtproc="$(grep -c processor /proc/cpuinfo)"

#! Used RAM (in MB)
ramusage=$(free -m | grep Mem | awk '{printf("%d/%d MB (%.2f%%)", $3, $2, $3/$2 * 100)}')

#!

echo "
	#Architecture: $arch
	#Physical CPUs: $phyproc
	#Virtual CPUs: $virtproc
	#RAM usage: $ramusage
"