#! /bin/bash

cd $DRONE_STACK
source setup.sh
roslaunch droneEKFStateEstimatorROSModule droneEKFStateEstimatorROSModule.launch --wait drone_id_int:="4" drone_id_namespace:="drone4"
