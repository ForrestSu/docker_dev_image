
sysctl -w kernel.core_pattern=/tmp/core-%e-%p-%t > /dev/null
ulimit -c unlimited