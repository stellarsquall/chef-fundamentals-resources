name 'load-balancer'
description 'Load Balancer Role'
run_list 'role[base]','recipe[myhaproxy]'