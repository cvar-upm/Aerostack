#! /bin/bash

cd $DRONE_STACK
source setup.sh 
roslaunch droneInterfaceROSModule droneInterface_jp_ROSModule.launch --wait drone_id_int:="4" drone_id_namespace:="drone4" 

