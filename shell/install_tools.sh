#!/bin/sh

cd `dirname "$0"`

OS_RELEASE=/etc/os-release

uname -a

if [ ! -f "${OS_RELEASE}" ]; then
  exit 1
fi

cat ${OS_RELEASE}
ID=$(cat ${OS_RELEASE} | grep "^ID=" | awk -F = '{print $2}' | sed 's/"//g')
echo "ID=$ID"

case $ID in
debian|ubuntu|devuan)
  ./install_tools_debian.sh
  ;;
alpine)
  ./install_tools_alpine.sh
  ;;
centos|fedora|rhel|ol)
  ./install_tools_centos.sh
  ;;
*)
  exit 1
esac

./chsh_all.sh
