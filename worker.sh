#! /bin/bash

case $1 in
  build) 
   echo -e "\e[0;32m building is started \e[0;0m"
    podman build -t yocto-imx8mp  .
   ;;
  run)
   echo -e "\e[0;32m The Container is started \e[0;0m"
    podman run -it --name imx8mp-container yocto-imx8mp 
   ;;
  bridge)
    podman run -it --name imx8mp-container -v $(pwd):/home/developer/yocto yocto-imx8mp 
   ;;
  clean)
    podman stop imx8mp-container
    podman rm imx8mp-container
    echo -e "\e[0;32m The Container(s) cleaned \e[0;0m"
  ;;
  rm)
    podman rmi yocto-imx8mp 
    echo -e "\e[0;32m The Container(s) removed \e[0;0m"
   ;;
   *)
   ;;
esac