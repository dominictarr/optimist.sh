#!/usr/bin/env bash

PREFIX=${PREFIX:-argv_}

argument () {
  if [ $STATE == ARG ]; then echo -n "$PREFIX"ARG_"$ARG"; let ARG=$ARG+1; fi
  echo =\""$1"\"
  STATE=ARG
}
argv () {
  echo '#!/usr/bin/env bash'
  STATE=ARG
  ARG=0
  while true; do

    case "$1" in
      --)
        if [ $STATE == VAL ]; then echo =\"true\"; fi
        STATE=ARG
        shift        
        for a in "$@"; do
          argument $a
        done
        return 0
      ;;
      --no-*)
        if [ $STATE == VAL ]; then echo =\"true\"; fi
        echo "$PREFIX""${1##--no-}"=\"false\"
        STATE=ARG
        ;;
      -*=*)
        if [ $STATE == VAL ]; then echo =\"true\"; fi
        echo $PREFIX`expr match "$1" '--*\(.*\)='`=\"`expr match "$1" '--*.*=\(.*\)$'`\"
        STATE=ARG
        ;;
      -*)
        if [ $STATE == VAL ]; then echo =\"true\"; fi
        echo -n $PREFIX`expr match "$1" '--*\(.*$\)'`
        STATE=VAL
        ;;
      *)
        argument "$1"
      ;;
    esac
    shift
    if [ "x$1" == x ]; then break; fi
  done

  if [ $STATE == VAL ]; then echo =\"true\"; fi

}

demand () {
PREFIX=demand_ parseargs "$@"
  . <(PREFIX=demand_ parseargs "$@")
  #echo $demand_ARG_0
  if [ x$demand_ARG_0 == x ]; then 
    echo $demand_ARG_1 >&2 
    exit 1
  fi
}


if [ $0 == $BASH_SOURCE ]; then parseargs $@; fi