#!/usr/bin/python
import os
import re
#sw_octeon5600-mc-stdeb to sw_e3600_6.2.0_2n_xxx-stdeb.bin.sig
#sw_octeon6600-mc-prod to sw_e3600_6.2.0_2n_xxx-prod.bin.sig
for f in [fi for fi in os.listdir(".") if os.path.isdir(fi)]:
    p = re.compile(r'sw_octeon\d600-mc-(stdeb|prod)')
    r = p.search(f)
    if r:
        dir_name = r.group()
        print dir_name
        model_pattern = re.compile(r'\d\d\d\d')
        version_pattern = re.compile(r'(stdeb|prod)$')
        model = model_pattern.search(dir_name).group()
        version = version_pattern.search(dir_name).group()
        file_name = 'sw_e'+model+'_6.2.0_2n_631298-'+version+'.bin.sig'

        source = os.path.join('/home/Build/qzhu/Firmware/NG/SonicOS/WorkSet/6.1.3/RFE_AA-DPI6/m2/target/oct_mips64/',dir_name,'firmware.bin.sig')
        target = os.path.join('/mnt/Public/Amos/AA_DPI_IPv6',file_name)
        remotehost = 'qzhu@10.103.49.251'
        os.system('scp "%s:%s" "%s"' % (remotehost,source, target) )
#        print source,target
