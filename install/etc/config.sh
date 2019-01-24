
DEBUG=debug
LOG=/tmp/debug.install.$(basename $0).log

MYDIR="/tmp/install"

# By default the terminus-console is installed
# You can include here other:

VCONSOLE="

KEYMAP=es
#FONT=ter-v32n
FONT=ter-v14n


"

LOCALEGEN="
es_ES.UTF-8 UTF-8
en_US.UTF-8 UTF-8
"

LOCALECONF="
LANG=en_US.UTF-8
#LANG=es_ES.UTF-8
LANGUAGE=es_ES:es
LC_MESSAGES=en_US.UTF-8
LC_ALL=

"

ZONEINFO="Europe/Madrid"





if [ -z "$DEBUG" ]; then true
else
	alias clear='echo ""'
	exec 1>>$LOG
	exec 2>&1
	set -x
fi
