function znajdz_i_zamien {
    find . -type f -exec sed -e "s=${1}=${2}=g" -i {} \;
}

function f {
    find . -iname '*${1}*'
}

function wypal_obraz {
    cdrecord -v dev=/dev/sr0 -data ${1}
}

function @ {
    grep -ir ${@} .
}

alias speedtest='wget -O /dev/null http://speedtest.wdc01.softlayer.com/downloads/test100.zip'

function TOP () {
  if [[ -n $@ ]] ; then
    COUNT=$@
  else
    COUNT=10
  fi

  history \
    | gawk '{print $2}' \
    | gawk 'BEGIN {FS="|"} {print $1}' \
    | sort \
    | uniq -c \
    | sort -rn \
    | head -n ${COUNT}
}

function ,play-urandom() {
    cat /dev/urandom | hexdump -v -e '/1 "%u\n"' | awk '{ split("0,2,4,5,7,9,11,12",a,","); for (i = 0; i < 1; i+= 0.0001) printf("%08X\n", 100*sin(1382*exp((a[$1 % 8]/12)*log(2))*i)) }' | xxd -r -p | aplay -c 2 -f S32_LE -r 16000
}

