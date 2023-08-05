#!/bin/bash

# 存储IP地址的数组
declare -a addresses

addresses+=("racknerd|LOS-ANGELES-DC01|23.228.107.2")
addresses+=("racknerd|LOS-ANGELES-DC02|204.13.154.3")
addresses+=("racknerd|SAN-JOSE|192.210.207.88")
addresses+=("racknerd|SEATTLE|192.3.253.2")
addresses+=("racknerd|UTAH|104.156.142.1")
addresses+=("racknerd|CHICAGO|198.23.228.15")
addresses+=("racknerd|DALLAS|198.23.249.100")
addresses+=("racknerd|NEW-YORK|69.58.3.171")
addresses+=("racknerd|NEW-JERSEY|192.3.165.30")
addresses+=("racknerd|ATLANTA|107.173.164.160")
addresses+=("racknerd|TAMPA|209.216.90.1")
addresses+=("racknerd|MIAMI|192.155.106.1")
addresses+=("racknerd|ASHBURN|107.173.166.10")
addresses+=("racknerd|MONTREAL|38.153.100.129")
addresses+=("racknerd|LONDON|185.239.172.14")
addresses+=("racknerd|AMSTERDAM|23.94.101.88")
addresses+=("ethernetservers|New Jersey, United States|172.81.42.54")
addresses+=("ethernetservers|Los Angeles, United States|140.99.154.106")
addresses+=("ethernetservers|Jacksonville, Florida|140.99.234.178")
addresses+=("dedipath|NY Metro (NYJ)|172.81.42.54")
addresses+=("dedipath|Los Angeles, California (LAX)|140.99.154.106")
addresses+=("dedipath|Las Vegas, Nevada (LAS)|86.38.218.202")
addresses+=("dedipath|Jacksonville, Florida (JAX)|140.99.234.178")
addresses+=("dedipath|Dallas, Texas (DAL)|185.161.69.26")
addresses+=("dedipath|Atlanta, GA (ATL)|45.9.15.195")
addresses+=("dedipath|Denver, CO (DEN)|172.81.40.35")
addresses+=("dedipath|Seattle, WA (SEF)|69.25.117.188")
addresses+=("dedipath|Phoenix, AZ (PHX)|69.25.116.107")
addresses+=("dedipath|San Jose, CA (SJE)|74.217.183.180")
addresses+=("greencloud|Los Angeles Datacenter|192.161.167.156")
addresses+=("greencloud|San Jose Datacenter|173.249.199.2")
addresses+=("greencloud|Phoenix Datacenter|173.249.203.193")
addresses+=("greencloud|Las Vegas Datacenter|199.241.143.254")
addresses+=("greencloud|Monticello Datacenter|199.102.44.80")
addresses+=("greencloud|Seattle Datacenter|216.244.83.34")
addresses+=("greencloud|Denver Datacenter|64.44.81.123")
addresses+=("greencloud|Ashburn Datacenter|172.106.7.194")
addresses+=("greencloud|Dallas Datacenter|64.44.147.6")
addresses+=("greencloud|Chicago Datacenter|167.88.10.4")
addresses+=("greencloud|Secaucus Datacenter|23.226.128.10")
addresses+=("greencloud|Bend Datacenter|155.254.16.14")
addresses+=("greencloud|Miami Datacenter|173.44.32.10")
addresses+=("greencloud|Jacksonville Datacenter|64.44.162.14")
addresses+=("greencloud|Buffalo Datacenter|96.9.249.58")
addresses+=("greencloud|Atlanta Datacenter|69.61.74.53")
addresses+=("greencloud|Kansas City Datacenter|192.187.107.154")
addresses+=("greencloud|Toronto Datacenter|192.187.107.154")
addresses+=("greencloud|Amsterdam Datacenter|46.182.111.246")
addresses+=("greencloud|Paris Datacenter|185.94.189.162")
addresses+=("greencloud|Frankfurt Datacenter|212.83.44.9")
addresses+=("greencloud|Coventry Datacenter|94.229.65.150")
addresses+=("greencloud|Manchester Datacenter|89.238.129.146")
addresses+=("greencloud|Bucharest Datacenter|185.45.12.22")
addresses+=("greencloud|Sofia Datacenter|94.156.35.72")
addresses+=("greencloud|Tokyo Datacenter |103.121.210.3")
addresses+=("greencloud|Singapore Datacenter DC1|89.187.162.1")
addresses+=("greencloud|Singapore Datacenter DC2|103.254.153.18")
addresses+=("greencloud|Hong Kong DC1|119.160.232.1")
addresses+=("greencloud|Hong Kong DC2|43.249.36.49")
addresses+=("greencloud|Hanoi Datacenter|103.199.17.252")
addresses+=("greencloud|Ho Chi Minh Datacenter|103.186.65.220")
addresses+=("buyvm|las-vegas-datacenter|209.141.56.135")
addresses+=("buyvm|new-jersey-datacenter|198.98.53.31")
addresses+=("buyvm|luxembourg-datacenter|104.244.76.191")
addresses+=("smarthost|CALIFORNIA (SOUTH)|23.228.222.50")
addresses+=("smarthost|TEXAS|45.35.132.2")
addresses+=("smarthost|NEVADA|199.43.206.3")
addresses+=("smarthost|COLORADO|66.11.121.252")
addresses+=("smarthost|FLORIDA (NORTH)|199.102.65.118")
addresses+=("smarthost|NEW YORK (WEST)|107.173.81.2")
addresses+=("smarthost|VIRGINIA|172.106.106.2")
addresses+=("smarthost|ILLINOIS|45.14.113.2")
addresses+=("smarthost|MASSACHUSETTS|38.242.7.129")
addresses+=("smarthost|WASHINGTON|162.210.250.241")
addresses+=("smarthost|NEW YORK OR NEW JERSEY|66.11.120.2")
addresses+=("smarthost|NETHERLANDS|185.251.118.130")
addresses+=("smarthost|UNITED KINGDOM|45.14.112.20")
addresses+=("smarthost|OREGON|139.64.132.2")
addresses+=("smarthost|MICHIGAN|147.189.140.2")
addresses+=("smarthost|MISSOURI|139.64.133.2")
addresses+=("smarthost|UTAH|185.127.92.1")
addresses+=("smarthost|ARIZONA|174.138.168.10")
addresses+=("smarthost|NEW JERSEY|174.136.228.4")
addresses+=("smarthost|CALIFORNIA (NORTH)|136.0.228.26")
addresses+=("smarthost|WEST VIRGINIA|194.62.165.2")
addresses+=("smarthost|INDIANA|176.111.216.2")
addresses+=("smarthost|WISCONSIN|176.111.219.2")
addresses+=("smarthost|GEORGIA|78.142.8.78")
addresses+=("smarthost|OHIO|45.141.15.2")
addresses+=("smarthost|CANADA|37.221.110.111")
addresses+=("smarthost|NORTH CAROLINA|174.136.230.20")
addresses+=("smarthost|FLORIDA (CENTRAL)|185.227.69.185")
addresses+=("smarthost|NEW MEXICO|185.101.23.2")

main_pid=$$
# 创建一个空数组来存储子进程pid
sub_pids=()
tmp_dir=$(mktemp -d)
if [ ! -d "$tmp_dir" ]; then
  echo "Failed to create temporary directory."
  exit 1
fi
# 存储ping的结果
declare -a results

cleanup() {
    #echo "Cleaning up..."
    # 删除所有子进程
    pkill -P $$
    # 删除临时目录
    rm -rf "$tmp_dir"
    exit
}
# 注册信号处理函数
trap 'cleanup' INT QUIT TERM

_red() {
    printf '\033[0;31;31m%b\033[0m' "$1"
}
_deep_red() {
    printf '\033[0;31;35m%b\033[0m' "$1"
}
_green() {
    printf '\033[0;31;32m%b\033[0m' "$1"
}
_yellow() {
    printf '\033[0;31;33m%b\033[0m' "$1"
}
_blue() {
    printf '\033[0;34;94m%b\033[0m' "$1"
}

show_progress() {
    local progress=$1
    local bar_length=100
    local completed_length=$((progress * bar_length / 100))
    local remaining_length=$((bar_length - completed_length))
    local bar=$(printf "%${completed_length}s" | tr ' ' '#')
    local space=$(printf "%${remaining_length}s" | tr ' ' ' ')
    printf "\r[%s%s] %d%%" "$bar" "$space" "$progress"
}

# 测试IP地址的延迟和丢包率
ping_test() {
  echo "启动 ping ..."

  # 每个ip的测试次数
  ip_test_count=$1
  # 每次ping的测试次数
  ping_test_count=$2

  total_addresses=${#addresses[@]}
  completed_addresses=0

  for address in "${addresses[@]}"; do
      touch "$tmp_dir/${address}_ping_test_temp_.result"
      (
        ip_addr=`echo $address | awk -F "|" '{print $3}'`
        total_delay=0
        total_packet_loss=0
        for ((i=1; i<=$ip_test_count; i++)); do
            pingmsg=`ping -c $ping_test_count $ip_addr`
            if echo "$pingmsg" | grep -iq "100.*% packet loss"; then
              echo "$address |超时|  100" > "$tmp_dir/${address}_ping_test_temp_.result"
              #echo "$address finish" > "$tmp_dir/${address}_ping_test_temp_.result"
              exit
            fi
          
            result=$(echo "$pingmsg" | tail -n 1)
            delay=$(echo $result | awk '{print $4}' | cut -d '/' -f 2)

            result=$(echo "$pingmsg" | tail -n 2 | head -n 1)
            packet_loss=$(echo $result | awk -F ',' '{print $3}' | awk -F '%' '{print $1}')

            total_delay=$(awk "BEGIN {printf \"%.2f\", $total_delay + $delay}")

            total_packet_loss=$(awk "BEGIN {printf \"%.2f\", $total_packet_loss + $packet_loss}")
        done
        avg_delay=$(echo "$total_delay" | awk -v count=$ip_test_count '{printf "%.2f", $1 / count}')
        avg_packet_loss=$(echo "$total_packet_loss" | awk -v count=$ip_test_count '{printf "%.2f", $1 / count}')
        echo "$address |$avg_delay |$avg_packet_loss" > "$tmp_dir/${address}_ping_test_temp_.result"
        #echo "$address finish" > "$tmp_dir/${address}_ping_test_temp_.result"
      ) &
      sub_pids+=($!)
      ((completed_addresses++))
      progress=$((completed_addresses * 100 / total_addresses))
      show_progress $progress
      sleep 0.2
  done

  #printf "\r\033[Kping启动完成, 等待结果统计..."
  echo
  echo "ping 启动完成, 等待结果统计 ..."

  while true; do
    #num_children=$(pgrep -P $main_pid | xargs ps -o comm= -p | grep -v sleep | wc -l)
    num_children=0
    for pid in "${sub_pids[@]}"; do
        if kill -0 $pid 2>/dev/null; then
            num_children=$((num_children + 1))
        fi
    done
    num_finish=$((total_addresses-num_children))
    progress=$((num_finish * 100 / total_addresses))
    show_progress $progress
    if [ $num_children -eq 0 ]; then
        break
    fi
    sleep 0.5
  done

  echo
  # 从临时文件读数据
  for address in "${addresses[@]}"; do
      result=$(cat "$tmp_dir/${address}_ping_test_temp_.result" | head -n 1)
      results+=("$result")
  done
  rm -rf  "$tmp_dir"
}

show_ping_result() {
  # 对结果进行排序，按延迟从低到高排序
  IFS=$'\n' sorted_results=($(printf "%s\n" "${results[@]}" | sort -t '|' -k4 -n))
  unset IFS

  # 超时的放在最后
  final_results=()
  timeout_results=()
  for result in "${sorted_results[@]}"; do
      if [[ $result == *"超时"* ]]; then
          timeout_results+=("$result")
      else
          final_results+=("$result")
      fi
  done
  final_results+=("${timeout_results[@]}")

  # 输出结果
  echo
  echo "厂商                 数据中心                        IP地址                平均延迟(ms)     平均丢包率(%)"
  echo "----------------------------------------------------------------------------------------------------"
  for result in "${final_results[@]}"; do
      str=$(echo "$result" | awk -F "|" '{printf "%-20s %-30s %-20s %-15s %-15s\n", $1, $2, $3, $4, $5}')

      if [[ $str == *"超时"* ]]; then
          _red "$str\n"
          continue
      fi

      delay_int=$(echo "$result" | awk -F "|" '{gsub(/ /, "", $4); print substr($4, 1, index($4, ".")-1)}')
      if [ $delay_int -le 100 ]; then
          _green "$str\n"
      elif [ $delay_int -le 150 ]; then
          _blue "$str\n"
      elif [ $delay_int -le 200 ]; then
          _yellow "$str\n"
      else
          _deep_red "$str\n"
      fi
  done
}

main() {
  ping_test 3 10 # ping_test 每个ip测试次数 每次测试ping的次数
  show_ping_result
}

main