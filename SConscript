Import('env')

import os

localEnv = env.Clone()

#============================ defines =========================================

#============================ helpers =========================================

#============================ SCons actions ===================================

def ActionUnzip(env,target,source):
    os.system("unzip NOOBS_v1_3_9.zip -d build/")

def ActionExtractRootTarXz(env,target,source):
    os.system("pwd")
    os.system("sudo mkdir build/os/OpenPi/root/")
    os.system("sudo tar -xJf build/os/OpenPi/root.tar.xz -C build/os/OpenPi/root/")

def ActionPythonPackageBottle(env,target,source):
    os.system("wget https://pypi.python.org/packages/source/b/bottle/bottle-0.12.7.tar.gz")
    os.system("tar -zxvf bottle-0.12.7.tar.gz")

def ActionPythonPackagePyDispatcher(env,target,source):
    os.system("wget https://pypi.python.org/packages/source/P/PyDispatcher/PyDispatcher-2.0.3.tar.gz")
    os.system("tar -zxvf PyDispatcher-2.0.3.tar.gz")

def ActionDownloadOpenWSN(env,target,source):
    os.system("wget https://github.com/openwsn-berkeley/openwsn-sw/archive/REL-1.8.0.zip")

def ActionUnzipOpenWSN(env,target,source):
    os.system("unzip REL-1.8.0.zip")

def ActionCompressRootTarXz(env,target,source):
    os.system("sudo tar -cJf build/os/OpenPi/root.tar.xz build/os/OpenPi/root/")

def ActionZip(env,target,source):
    os.system("zip -r OpenPi.zip build/*")

#============================ SCons targets ===================================

build = localEnv.Command(
    'dummy.out',[],
    [
        #===== NOOBS get
        
        Copy( Dir('#'), localEnv['OW_PATH_NOOBS_IN'] ),
        Delete("build"),
        Mkdir("build"),
        ActionUnzip,
        Delete("NOOBS_v1_3_9.zip"),
        
        #===== NOOBS clean up
        
        Delete("build/os/Arch"),
        Delete("build/os/OpenELEC"),
        Delete("build/os/Pidora"),
        Delete("build/os/RaspBMC"),
        Delete("build/os/RISC_OS"),
        
        #===== NOOBS marketing
        
        # default logo
        Copy("build/defaults/slides/A.png","bits_n_pieces/openwsn_logo.png"),
        
        # rename distribution
        Move("build/os/OpenPi","build/os/Raspbian"),
        
        # installation options
        Copy("build/os/OpenPi/os.json","bits_n_pieces/os.json"),
        Copy("build/os/OpenPi/flavours.json","bits_n_pieces/flavours.json"),
        
        # installation logo
        Delete("build/os/OpenPi/Raspbian.png"),
        Copy("build/os/OpenPi/OpenPi.png","bits_n_pieces/OpenPi.png"),
        
        # installation intro slides (shown during installation)
        Delete("build/os/OpenPi/slides_vga"),
        Copy("build/os/OpenPi/slides_vga","bits_n_pieces/slides_vga"),
        
        #===== OpenPi customization
        
        # extract root
        ActionExtractRootTarXz,
        Delete("build/os/OpenPi/root.tar.xz"),
        
        # change desktop background image (do here, after root/ un-tared)
        Copy("build/os/OpenPi/root/etc/alternatives/desktop-background","bits_n_pieces/desktop-background"),
        
        # install python module dependencies (bottle, PyDispatcher)
        ActionPythonPackageBottle,
        Move("build/os/OpenPi/root/usr/local/lib/python2.7/site-packages/","bottle-0.12.7/bottle.py"),
        Delete("bottle-0.12.7.tar.gz"),
        Delete("bottle-0.12.7/"),
        ActionPythonPackagePyDispatcher,
        Move("build/os/OpenPi/root/usr/local/lib/python2.7/site-packages/","PyDispatcher-2.0.3/pydispatch"),
        Delete("PyDispatcher-2.0.3.tar.gz"),
        Delete("PyDispatcher-2.0.3/"),
        
        # install OpenWSN-SW
        ActionDownloadOpenWSN,
        ActionUnzipOpenWSN,
        Delete("REL-1.8.0.zip"),
        Move("openwsn-sw","openwsn-sw-REL-1.8.0"),
        Move("build/os/OpenPi/root/home/pi/","openwsn-sw"),
        Copy("build/os/OpenPi/root/etc/","bits_n_pieces/modules"),
        
        # customize boot message, start OpenVisualizer on boot
        Copy("build/os/OpenPi/root/etc","bits_n_pieces/rc.local"),
        
        # compress root
        ActionCompressRootTarXz,
        Delete("build/os/OpenPi/root/"),
        
        #===== OpenPi wrap-up and publish
        
        # create final zip
        ActionZip,
        Delete("build"),
        
        # copy to final location
        Copy( localEnv['OW_PATH_OPENPI_OUT'], "OpenPi.zip" ),
    ]
)

localEnv.Alias('build', build)
