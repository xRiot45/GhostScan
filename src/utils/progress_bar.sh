#!/bin/bash

progress_bar() {
    echo -ne "\e[33m[*]\e[0m Scanning "
    for i in {1..30}; do
        echo -ne "▓"
        sleep 0.05
    done
    echo -e " \e[32m[DONE]\e[0m"
}
