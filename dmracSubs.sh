#!/bin/bash

show_help(){
  echo "Usages:dmracSubs [domains]"
  echo 
  echo "Example:"
  echo " dmracSubs google.com"
  echo "  dmracSubs -o google-subs.txt google.com"
  echo 
  echo "Options:"
  echo " -h, --help   Show this help message"
  echo " -o FILE    Save output to FILE"
}

find_domains(){
  local domain=$1 
  local outputFile=$2

  if [[ -z "$domain" ]];then
    echo "Error: No domain specified"
    show_help
    exit 1
  fi

  local dmarc_hash
  dmarc_hash=$(curl -s "https://dmarc.live/info/$domain" | grep -oP "dmarc_hash:'\K[^']+")
  if [[ -z "$dmarc_hash" ]]; then
    echo "Error: Check if domain is correct $domain or doamin may not have dmarc records"
    exit 1
  fi
  
  local domains_raw
  domains_raw=$(curl -s "https://dmarc.live/api/related/$dmarc_hash" | grep -oP '"domains":\[\K[^\]]+')

  IFS=',' read -r -a domain_array <<< "$(echo "$domains_raw" | sed 's/"//g')"
  
  if [[ -n "$output_file" ]]; then
    printf "%s\n" "${domain_array[@]}" > "$output_file"
  else
    printf "%s\n" "${domain_array[@]}" > "$output_file"
    for d in "${domain_array[@]}"; do
      echo "$d"
    done
  fi

  RELATED_DOMAINS=("${domain_array[@]}")

}

output_file=""
while getopts ":o:h" opt; do
  case $opt in
    o)
      output_file="$OPTARG"
      ;;
    h)
      show_help
      exit 0
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      show_help
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      show_help
      exit 1
      ;;
  esac
done
shift $((OPTIND -1))

# Check for domain argument
if [[ $# -lt 1 ]]; then
  echo "Error: Domain argument missing."
  show_help
  exit 1
fi

domain=$1
find_domains "$domain" "$output_file"



