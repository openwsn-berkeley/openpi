Import('env')

import zipfile
import os.path
import os
import shutil

localEnv = env.Clone()

# unzip a file
def unzip(path):
    zfile = zipfile.ZipFile(path)
    zfile.extractall(os.getcwd())
    zfile.close()

# delete OSes but Raspbian
def deleteOSes(path):
    rmPath = os.listdit(path+"os")
    for direcotry in rmPath:
        if not directory == "Raspbian/" or not directory == "Data_Partition/":
            shutil.rmtree(directory)


build = localEnv.Command(
    'dummy.out',
    [],
    [
        # ***** unzip and cleanup *****
        # copy NOOBS to current directory
        Copy( Dir('#'), localEnv['OW_PATH_NOOBS_IN'] ),
        # unzip NOOBS
        unzip("NOOBS_v1_3_10.zip"),
        # delete OSes
        deleteOSes("OpenPi/");
        
        # ***** customize marketing *****
        # replace default/slides/A.png by openwsn logo
        # Done
        # replace os/Raspbian/slides_vga/A.png, B.png......,G.png by colourful openwsn logo
        # Done
        # replace os/Raspbian.png by openpi.png
        # Done
        # named os/Raspbian/ by os/OpenPi/
        # Done
        # replace Raspbian by OpenPi in os/OpenPi/os.json and os/OpenPi/flavours.json files
        # Done
        
        # ***** functional customization *****
        # uncompress root.tar.xz root,
        # Done. (execute "tar -xJf root.tar.xz root/" command in Ubuntu environment)
        # download newest release of openwsn-sw and unzip it to /root/home/pi
        # Done.
        # install dependencies python module (bottle, PyDispatcher)
        # Done. (just extract the tar packages to /usr/local/lib/python.27/site-packages)
        # customize the boot to print the openwsn banner
        # Done. (modified the rc.local file located at /root/etc/)
        # start openvisulizer when boot
        # TODO.
        # compress root
        # Done. (using tar -cJf ../root.tar.xz ./ in ubuntu environment)
        
        # ***** pack up *****
        # zip noobs,
        # Done.
        # copy to final location
        # TODO.
    ]
)
localEnv.Alias('build', build)
