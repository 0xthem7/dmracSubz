# DMRACSubs - Subdomains Sharing Same DMARC Record

`dmracSubs.sh` is a simple Bash script that fetches domains sharing the **same DMARC record** using [dmarc.live](https://dmarc.live). Useful for reconnaissance, OSINT, and bug bounty expansion.

---

## Installation
```bash
curl -sO https://raw.githubusercontent.com/0xthem7/dmracSubz/main/dmracSubs.sh
chmod +x dmracSubs.sh

```
Or, 
```
curl -sLo /usr/local/bin/dmracSubs https://raw.githubusercontent.com/0xthem7/dmracSubz/main/dmracSubs.sh
chmod +x /usr/local/bin/dmracSubs
```

## usages 
```
dmracSubs.sh example.com
```

Save to file 
```
dmracSubs.sh -o output.txt example.com
```



