Import('env')

import zipfile
import tarfile
import os.path
import os
import urllib

localEnv = env.Clone()

#============================ defines =========================================

#============================ helpers =========================================

def wget(url):
    packageName = url.split('/')[-1]
    urllib.urlretrieve(url,packageName)

#============================ SCons actions ===================================

def ActionUnzip(env,target,source):
    zfile = zipfile.ZipFile("NOOBS_v1_3_9.zip")
    zfile.extractall("build/")
    zfile.close()

def actionInstallPythonPackages(env,target,source):
    wget('https://pypi.python.org/packages/source/b/bottle/bottle-0.12.7.tar.gz')
    wget('https://pypi.python.org/packages/source/P/PyDispatcher/PyDispatcher-2.0.3.tar.gz')

def actionUntar(env,target,source):
    tfile = tarfile.open('bottle-0.12.7.tar.gz','r:gz')
    tfile.extractall(os.getcwd())
    tfile.close()

#============================ SCons targets ===================================

build = localEnv.Command(
    'dummy.out',['NOOBS_v1_3_9.zip'],
    [
        #===== get NOOBS
        #Copy( Dir('#'), localEnv['OW_PATH_NOOBS_IN'] ),
        
        #===== unzip and clean up NOOBS
        Delete("build"),
        Mkdir("build"),
        ActionUnzip,
        Delete("build/os/Arch"),
        Delete("build/os/OpenELEC"),
        Delete("build/os/Pidora"),
        Delete("build/os/RaspBMC"),
        Delete("build/os/RISC_OS"),
        
        #===== marketing customization
        Copy("build/defaults/slides/A.png","bits_n_pieces/openwsn_logo.png"),
        Delete("build/os/Raspbian/slides_vga"),
        Copy("build/os/Raspbian/slides_vga","bits_n_pieces/slides_vga"),
        Delete("build/os/Raspbian/Raspbian.png"),
        Copy("build/os/Raspbian/OpenPi.png","bits_n_pieces/OpenPi.png"),
        Move("build/os/OpenPi","build/os/Raspbian"),
        Copy("build/os/OpenPi/os.json","bits_n_pieces/os.json"),
        Copy("build/os/OpenPi/flavours.json","bits_n_pieces/flavours.json"),
        
        #===== functional customization
        # uncompress root.tar.xz root,
        # Done. (execute "tar -xJf root.tar.xz root/" command in Ubuntu environment)
        # download newest release of openwsn-sw and unzip it to /root/home/pi
        # Done.
        # enable ipv6. (default the ipv6 is not enabled.)
        # Done. (Add ipv6 at the end of /etc/modules)
        # install dependencies python module (bottle, PyDispatcher)
        #actionInstallPythonPackages,
        #actionUntar,
        # Done. (just extract the tar packages to /usr/local/lib/python.27/site-packages)
        # customize the boot to print the openwsn banner
        # Done. (modified the rc.local file located at /root/etc/)
        # start openvisulizer when boot
        # Done. (edit the rc.local file located at /root/etc: 1. cd to openVisualizerWeb.py directory 2. sudo python openVisualizerWeb.py)
        # compress root
        # Done. (using tar -cJf ../root.tar.xz ./ in ubuntu environment)
        
        #===== wrap-up and publish
        # zip noobs,
        # Done.
        # copy to final location
        # TODO.
    ]
)

localEnv.Alias('build', build)
