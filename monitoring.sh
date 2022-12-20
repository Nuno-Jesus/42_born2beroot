arch=$(uname -a)
phyproc=$(top -n1 | grep "%Cpu" | wc -l)
virtproc=""


echo "
	#Architecture: $arch
	#Physical CPUs: $phyproc
	#Virtual CPUs: $virtproc
"