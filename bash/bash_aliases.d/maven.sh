#!/usr/bin/env bash

maven() {
    usage() {
        echo
        echo "Maven utilities :D"
        echo
        echo "Usage: maven [-c|r|b]"
        echo
        echo "Options:"
        echo "   -c     Clean package, skip tests."
        echo "   -r     Run spring-boot, skip tests."
        echo "   -b     Build: clean and run."
        echo
    }

    PASSED_OPT="true"
    local OPTIND=1
    while getopts :crb opt; do
        case $opt in
        c)
            mvn clean package -Dmaven.test.skip
            return
            ;;
        r)
            mvn spring-boot:run -Dmaven.test.skip
            return
            ;;
        b)
            mvn clean package -Dmaven.test.skip
            mvn spring-boot:run -Dmaven.test.skip
            return
            ;;
        *)
            usage
            return
            ;;
        esac
    done

    PASSED_OPT=
    [ -z "$PASSED_OPT" ] && usage && return
}
