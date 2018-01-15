name 'web'
description 'Web Server Role'
run_list 'recipe[myusers]','recipe[workstation]','recipe[apache]'