#!/bin/bash
# tag docker-images

soMessage()
# always show such a message.  If known terminal, print the message
# in reverse video mode. This is the other way, not using escape sequences
{
    if [ "$TERM" = xterm -o "$TERM" = vt100 -o "$TERM" = xterm-256color  -o "$TERM" = screen ] ; then
        tput smso
        /bin/echo $* 1>&2
        tput rmso
    else
        /bin/echo $* 1>&2
    fi
}

error()
{
    soMessage 'ERROR:'$*
}

errorExit()
{
    if [[ $# -lt 2 ]] ; then
        error wrong call to to errorExit.
        exit 222
    fi
    EXITCODE=$1 ; shift
    error $* 1>&2
    exit $EXITCODE
}

_imageName=centos-extd
_date=$(date +%y%m%d)
_sha=$(docker inspect --format='{{.Id}}' $_imageName)
_sha=$(echo $_sha | sed 's/:/_/g')

#echo SHA checksum is $_sha
echo EXECUTING THE COMMANDS...

echo docker tag $_imageName ioeechina/$_imageName:latest
docker tag $_imageName ioeechina/$_imageName:latest

#docker tag $_imageName:191016 ioeechina/$_imageName:191016
echo docker tag $_imageName ioeechina/$_imageName:$_date
docker tag $_imageName ioeechina/$_imageName:$_date

# docker tag $_imageName:191016 ioeechina/$_imageName:191016-sha256_63607992c10468484347be8d6f03ae8f3bbbe133274ff004a562a02c61fb673b
echo docker tag $_imageName ioeechina/$_imageName:$_date-$_sha
docker tag $_imageName ioeechina/$_imageName:$_date-$_sha

# push latest
echo docker push ioeechina/$_imageName:latest
docker push ioeechina/$_imageName:latest

echo docker push ioeechina/$_imageName:$_date
docker push ioeechina/$_imageName:$_date

echo docker push ioeechina/$_imageName:$_date-$_sha
docker push ioeechina/$_imageName:$_date-$_sha
