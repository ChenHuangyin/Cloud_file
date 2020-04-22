import nmap
import os
iptable = ["192.168.20.5","192.168.20.15","192.168.20.20"]


def scan_ip_survial(ip):
    nmScan = nmap.PortScanner()
    scanner = nmScan.scan(hosts=ip, arguments='-sn')
    for res in scanner['scan'].values():
        if res['status']['state'] == 'up':
            return True


def get_all_survial_hosts():
    survial_hosts = []
    ip_lists = iptable
    for ip in ip_lists:
        scan_rst = scan_ip_survial(ip)
        if scan_rst: 
            survial_hosts.append(ip)
    return survial_hosts

res = get_all_survial_hosts()
num = len(res)

if num == 3:
    print("You got the final flag! You are the winner!!!")
else:
    print("Try to shutdown all the other three VM in the ctf network and run this file again! ")
    
input()


