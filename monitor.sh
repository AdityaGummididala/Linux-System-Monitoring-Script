#!/bin/bash 

# (#!) is called shebang 
# it is a special line that is used in the beginning of a script which tells the operating system which interpreter to use when executing the script.
# #!/bin/bash  this line tells the operating system to use bash interpreter while executing/running the script

CPU_Usage=$(top -bn1 | grep %Cpu | awk '{print $2}')
# this line gets the Cpu Usage from the top command and assigns to the variable CPU_Usage. 
# Top Command displays a realtime list of all processes that are currently running,along with their Cpu usage and Memory Usage.
# -bn1 option tells the top command to display only one line of the output.
# grep command searches for the line that conatins the string %Cpu.
# awk command prints the second field(print $2) of the line which is the CPU Usage.


RAM_Usage=$(free -m | awk '/Mem:/ {print $3}')
# this line gets the Ram/Memory Usage from the free command and assigns to the variable RAM_Usage.
# free command displays all the amount of that is free and used memory on the system.
# -m option tells free command to display the output in mb that is megabytes.
# awk command prints the third field of the line which is the total amount of memory that is currently used by the system.

DISK_Usage=$(df -h / | grep / | awk '{print $5}')
# this line gets the Disk Usage from the df command and assigns to the variable DISK_Usage.
# df command displays all the amount that is free and the used disk space on the system.
# -h option tells the df to display the output in human-readable format.
# "/" tells df to display the disk usage for the root directory
# grep command searches for the line that contains the string / i.e. root .
# awk command prints the fifth field of the line which is the percentage of disk space that is used.

temp=$(sensors | grep CPU | awk '{print $3}')

# If the temp is blank, then it will set it to "Unknown"
if [[ -z "$temp" ]]; then
  temp="Unknown"
fi
# this line gets the CPU Temperature from the sensors command and assigns it to the temp variable.
# the sensors command gets/displays the temperature of various sensors on the system.
# grep command searches for the line that has the string CPU
# awk command prints the third field of the line which is the temperature of the CPU.
# if the temp variable is empty then the temp is set to unknown.
#Note:-
#make sure the sensors command is installed 
#sudo apt install lm-sensors (for ubuntu)
#check it using the command "sensors"

speed=$(speedtest-cli | grep Download | awk '{print $2}')
#this line gets the speed of the internet from he command speedtest-cli and assigns it to the variable speed
#speedtest-cli command measures the speed of the internet
#grep command searches for the line that contains the string download.
#awk command prints the second field of the line which is the download speed.
#note:-
#make sure that you've installed speedtest-cli
#if not sudo apt install speedtest-cli
#check it using the command speedtest-cli

echo "CPU Usage: $CPU_Usage%"  #this prints CPU Usage to the console
echo "Memory Usage: $RAM_Usage MB" #this prints Memory Usage to the console
echo "Disk space Usage: $DISK_Usage%" #this prints Disk Space Usage to the console
echo "Cpu Temperature: $temp" #this prints CPU Temperature to the console
echo "Wifi/Lan/Internet Speed: $speed Mbps"  #this prints internet speed to the console

