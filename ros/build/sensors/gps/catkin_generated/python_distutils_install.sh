#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
    DESTDIR_ARG="--root=$DESTDIR"
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/neil/Workspace/self-driving-golf-cart/ros/src/sensors/gps"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/neil/Workspace/self-driving-golf-cart/ros/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/neil/Workspace/self-driving-golf-cart/ros/install/lib/python2.7/dist-packages:/home/neil/Workspace/self-driving-golf-cart/ros/build/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/neil/Workspace/self-driving-golf-cart/ros/build" \
    "/usr/bin/python2" \
    "/home/neil/Workspace/self-driving-golf-cart/ros/src/sensors/gps/setup.py" \
    build --build-base "/home/neil/Workspace/self-driving-golf-cart/ros/build/sensors/gps" \
    install \
    $DESTDIR_ARG \
    --install-layout=deb --prefix="/home/neil/Workspace/self-driving-golf-cart/ros/install" --install-scripts="/home/neil/Workspace/self-driving-golf-cart/ros/install/bin"
