name 'web'
description 'Web Server Role'
run_list 'role[base]','recipe[workstation]','recipe[apache]'