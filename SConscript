Import('env')

import os

localEnv = env.Clone()

#============================ defines =========================================

#============================ helpers =========================================

def syscall(cmd,dry_run=False):
    print cmd
    os.system(cmd)

#============================ SCons actions ===================================

def ActionUnzip(env,target,source):
    syscall("unzip NOOBS_v1_3_9.zip -d build/")

def ActionCustomizeOpenPi(env,target,source):
    
    # extract root
    syscall("sudo mkdir build/os/OpenPi/root/")
    syscall("sudo tar -xJf build/os/OpenPi/root.tar.xz -C build/os/OpenPi/root/")
    syscall("sudo rm -Rf build/os/OpenPi/root.tar.xz")
    
    # change desktop background image
    syscall("sudo rm build/os/OpenPi/root/etc/alternatives/desktop-background")
    syscall("sudo cp bits_n_pieces/desktop-background build/os/OpenPi/root/etc/alternatives/desktop-background")
    
    # install python module dependencies (bottle, PyDispatcher)
    syscall("wget https://pypi.python.org/packages/source/b/bottle/bottle-0.12.7.tar.gz")
    syscall("tar -zxvf bottle-0.12.7.tar.gz")
    syscall("sudo mv bottle-0.12.7/bottle.py build/os/OpenPi/root/usr/local/lib/python2.7/site-packages/")
    syscall("sudo rm bottle-0.12.7.tar.gz")
    syscall("sudo rm -Rf bottle-0.12.7/")
    syscall("wget https://pypi.python.org/packages/source/P/PyDispatcher/PyDispatcher-2.0.3.tar.gz")
    syscall("tar -zxvf PyDispatcher-2.0.3.tar.gz")
    syscall("sudo mv PyDispatcher-2.0.3/pydispatch build/os/OpenPi/root/usr/local/lib/python2.7/site-packages/")
    syscall("sudo rm PyDispatcher-2.0.3.tar.gz")
    syscall("sudo rm -Rf PyDispatcher-2.0.3/")
        
    # install OpenWSN-SW
    syscall("wget https://github.com/openwsn-berkeley/openwsn-sw/archive/REL-1.8.0.zip")
    syscall("unzip REL-1.8.0.zip")
    syscall("sudo rm REL-1.8.0.zip")
    syscall("sudo mv openwsn-sw-REL-1.8.0 openwsn-sw")
    syscall("sudo mv openwsn-sw build/os/OpenPi/root/home/pi/")
    
    # update modules to run
    syscall("sudo cp bits_n_pieces/modules build/os/OpenPi/root/etc/")
    
    # customize boot message, start OpenVisualizer on boot
    syscall("sudo cp bits_n_pieces/rc.local build/os/OpenPi/root/etc")
    
    # compress root
    syscall("sudo tar -cJf build/os/OpenPi/root.tar.xz build/os/OpenPi/root/")
    syscall("sudo rm -Rf build/os/OpenPi/root/")

def ActionZip(env,target,source):
    syscall("cd build")
    syscall("zip -r ../OpenPi.zip *")
    syscall("cd ..")

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
