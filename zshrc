alias ll='ls -al --color=auto'

ulimit -c unlimited

sysctl -w kernel.core_pattern=/tmp/core-%e-%p-%t > /dev/null
