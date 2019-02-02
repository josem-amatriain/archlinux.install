if [ $? -eq 0 ]; then true
else
	errorCallBack "$*"
fi