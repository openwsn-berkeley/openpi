Import('env')

import os

localEnv = env.Clone()

#============================ defines =========================================

#============================ helpers =========================================

#============================ SCons actions ===================================

def ActionUnzip(env,target,source):
    os.system("unzip NOOBS_v1_3_9.zip -d build/")

def ActionCustomizeOpenPi(env,target,source):
    
    # extract root
    os.system("sudo mkdir build/os/OpenPi/root/")
    os.system("sudo tar -xJf build/os/OpenPi/root.tar.xz -C build/os/OpenPi/root/")
    os.system("sudo rm -Rf build/os/OpenPi/root.tar.xz")
    
    # change desktop background image
    os.system("sudo rm build/os/OpenPi/root/etc/alternatives/desktop-background")
    os.system("sudo cp bits_n_pieces/desktop-background build/os/OpenPi/root/etc/alternatives/desktop-background")
    
    # install python module dependencies (bottle, PyDispatcher)
    os.system("wget https://pypi.python.org/packages/source/b/bottle/bottle-0.12.7.tar.gz")
    os.system("tar -zxvf bottle-0.12.7.tar.gz")
    os.system("sudo mv bottle-0.12.7/bottle.py build/os/OpenPi/root/usr/local/lib/python2.7/site-packages/")
    os.system("sudo rm bottle-0.12.7.tar.gz")
    os.system("sudo rm -Rf bottle-0.12.7/")
    os.system("wget https://pypi.python.org/packages/source/P/PyDispatcher/PyDispatcher-2.0.3.tar.gz")
    os.system("tar -zxvf PyDispatcher-2.0.3.tar.gz")
    os.system("sudo mv PyDispatcher-2.0.3/pydispatch build/os/OpenPi/root/usr/local/lib/python2.7/site-packages/")
    os.system("sudo rm PyDispatcher-2.0.3.tar.gz")
    os.system("sudo rm -Rf PyDispatcher-2.0.3/")
        
    # install OpenWSN-SW
    os.system("wget https://github.com/openwsn-berkeley/openwsn-sw/archive/REL-1.8.0.zip")
    os.system("unzip REL-1.8.0.zip")
    os.system("sudo rm REL-1.8.0.zip")
    os.system("sudo mv openwsn-sw-REL-1.8.0 openwsn-sw")
    os.system("sudo mv openwsn-sw build/os/OpenPi/root/home/pi/")
    
    # update modules to run
    os.system("sudo cp bits_n_pieces/modules build/os/OpenPi/root/etc/")
    
    # customize boot message, start OpenVisualizer on boot
    os.system("sudo cp bits_n_pieces/rc.local build/os/OpenPi/root/etc")
    
    # compress root
    os.system("sudo tar -cJf build/os/OpenPi/root.tar.xz build/os/OpenPi/root/")
    os.system("sudo rm -Rf build/os/OpenPi/root/")

def ActionZip(env,target,source):
    os.system("zip -r OpenPi.zip build/*")

#============================ SCons targets ===================================

build = localEnv.Command(
    'dummy.out',[],
    [
        #===== NOOBS get
        
        Delete("build"),
        Copy( Dir('#'), localEnv['OW_PATH_NOOBS_IN'] ),
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
        
        ActionCustomizeOpenPi,
        
        #===== OpenPi wrap-up and publish
        
        # create final zip
        ActionZip,
        Delete("build"),
        
        # copy to final location
        Copy( localEnv['OW_PATH_OPENPI_OUT'], "OpenPi.zip" ),
    ]
)

localEnv.Alias('build', build)
