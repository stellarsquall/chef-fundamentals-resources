name 'web'
description 'Web Server Role'
run_list 'recipe[workstation]','recipe[apache]'