#!/bin/bash

echo "-----------------------"
echo "Installing ncurses"
echo "-----------------------"
sudo apt-get -y install libncurses5
sudo apt-get -y install ncurses-bin
sudo apt-get -y install ncurses-dev

echo "-----------------------"
echo "Installing boost"
echo "-----------------------"
sudo apt-get -y install libboost1.54-dev

echo "-----------------------"
echo "Installing expect"
echo "-----------------------"
sudo apt-get -y install expect

echo "---------------------------"
echo "Installing Lapack, Blas, protobuf and F2C Libraries"
echo "---------------------------"
sudo apt-get -y install liblapack3 liblapack-dev
sudo apt-get -y install libblas3 libblas-dev
sudo apt-get -y install libf2c2 libf2c2-dev
sudo apt-get -y install protobuf-compiler

echo "---------------------------"
echo "Installing ARdrone Autonomy dependencies"
echo "---------------------------"
sudo apt-get -y install libsdl1.2-dev
sudo apt-get -y install libudev-dev
sudo apt-get -y install libiw-dev

if [ "$ROS_DISTRO" = "kinetic" ]
then
	echo "----------------------------"
	echo "Install driver common required in kinectic"
	echo "----------------------------"
	mkdir -p /tmp/driver_common/src
	cd /tmp/driver_common/src
	git clone https://github.com/ros-drivers/driver_common
	cd ..
	catkin_make install -DCMAKE_INSTALL_PREFIX=/tmp/ros/$ROS_DISTRO
	sudo cp -R /tmp/ros/$ROS_DISTRO /opt/ros/
	rm -rf /tmp/ros
	rm -rf /tmp/driver_common

	echo "----------------------------"
	echo "Install keyboard required in kinectic"
	echo "----------------------------"
	mkdir -p /tmp/keyboard/src
	cd /tmp/keyboard/src
	git clone https://github.com/lrse/ros-keyboard.git
	cd ..
	catkin_make install -DCMAKE_INSTALL_PREFIX=/tmp/ros/$ROS_DISTRO
	sudo cp -R /tmp/ros/$ROS_DISTRO /opt/ros/
	rm -rf /tmp/ros
	rm -rf /tmp/keyboard
fi

if [ "$ROS_DISTRO" = "melodic" ]
then
	echo "----------------------------"
	echo "Install driver common required in melodic"
	echo "----------------------------"
	mkdir -p /tmp/driver_common/src
	cd /tmp/driver_common/src
	git clone https://github.com/ros-drivers/driver_common
	cd ..
	catkin_make install -DCMAKE_INSTALL_PREFIX=/tmp/ros/$ROS_DISTRO
	sudo cp -R /tmp/ros/$ROS_DISTRO /opt/ros/
	rm -rf /tmp/ros
	rm -rf /tmp/driver_common

	echo "----------------------------"
	echo "Install keyboard required in melodic"
	echo "----------------------------"
	mkdir -p /tmp/keyboard/src
	cd /tmp/keyboard/src
	git clone https://github.com/lrse/ros-keyboard.git
	cd ..
	catkin_make install -DCMAKE_INSTALL_PREFIX=/tmp/ros/$ROS_DISTRO
	sudo cp -R /tmp/ros/$ROS_DISTRO /opt/ros/
	rm -rf /tmp/ros
	rm -rf /tmp/keyboard
fi


#echo "---------------------------"
#echo "Installing Bebop Autonomy dependencies"
#echo "---------------------------"
#sudo apt-get -y install build-essential python-rosdep python-catkin-tools
#cd ${AEROSTACK_WORKSPACE}
#rosdep update
#rosdep install --from-paths src/quadrotor_stack/stack/droneDrivers/driversPlatforms/driverBebopDrone/bebop_autonomy -i

echo "---------------------------"
echo "Installing Sound Play & Dependencies"
echo "---------------------------"
sudo apt-get -y install ros-$ROS_DISTRO-audio-common
sudo apt-get install -y libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev

echo "---------------------------"
echo "Installing Voices for Sound Play"
echo "---------------------------"
sudo apt-get -y install festlex-cmu
sudo apt-cache search festvox
# British English male speaker for festival, 16khz sample rate [voice_rab_diphone]
sudo apt-get -y install festvox-rablpc16k
# American English male speaker for festival, 16khz sample rate [voice_kal_diphone]
sudo apt-get -y install festvox-kallpc16k
# Castilian Spanish male speaker for Festival [voice_el_diphone]
sudo apt-get -y install festvox-ellpc11k
echo "------------------------------------------------------"
echo "Installing qwt library"
echo "------------------------------------------------------"
sudo apt-get -y install libqwt-headers
sudo apt-get -y install libqwt-qt5-dev
sudo apt-get -y install libzbar-dev
echo "------------------------------------------------------"
echo "Installing xfce4-terminal"
echo "------------------------------------------------------"
sudo apt-get -y install xfce4-terminal -y
echo "------------------------------------------------------"
echo "Installing Ueyecamera drivers"
echo "------------------------------------------------------"
sudo ${AEROSTACK_STACK}/installation/drivers/ueyesdk-setup-4.80-usb-amd64.gz.run

#echo "---------------------------"
#echo "Installing Navigation Stack dependencies"
#echo "---------------------------"
#sudo apt-get -y install ros-jade-pcl-ros
#sudo apt-get -y install ros-jade-mrpt-navigation
#sudo apt-get -y install ros-jade-amcl
#sudo apt-get -y install ros-jade-move-base

#echo "----------------------------"
#echo "Installing Mavros dependencies"
#echo "----------------------------"
#sudo apt-get -y install ros-$ROS_DISTRO-control-toolbox
#sudo apt-get -y install ros-$ROS_DISTRO-mavlink
#cd ${AEROSTACK_STACK}
#mkdir temp && cd $_
#if [ "$ROS_DISTRO" == "jade" ]  ;
#then
  #wget http://packages.ros.org/ros-shadow-fixed/ubuntu/pool/main/r/ros-jade-mavlink/ros-jade-mavlink_2016.5.20-0trusty-20160520-075452-0700_amd64.deb
  #sudo dpkg -i *mavlink*deb
#  sudo dpkg -i installation/drivers/*mavlink*deb
#else
#  echo "!!!Error installing Mavros dependencies. Distro non supported!!!"
#fi
#cd ${AEROSTACK_STACK}
#rm -rf ./temp
#rm -rf temp/

echo "------------------------------------------------------"
echo "Installing All ROS dependencies"
echo "------------------------------------------------------"
rosdep update
rosdep install -r --from-paths ${AEROSTACK_WORKSPACE} --ignore-src --rosdistro=$ROSDISTRO

