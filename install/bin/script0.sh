#!/bin/bash -x

errorCallBack() { echo "$*" }

ls $0
source checkError.sh "Prueba $0"


ls x$0 
source checkError.sh "Error leyendo x$0"

