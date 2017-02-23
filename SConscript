Import('env')

import os

localEnv = env.Clone()

#============================ defines =========================================

#============================ helpers =========================================

def syscall(cmd):
    print '>>> {0}'.format(cmd)
    os.system(cmd)

#============================ SCons actions ===================================

def ActionBuild(env,target,source):
    
    #===== NOOBS get
    
    syscall("rm -Rf build/")
    syscall("cp {0} .".format(localEnv['OW_PATH_NOOBS_IN']))
    syscall("mkdir build")
    syscall("unzip NOOBS_v1_9_0.zip -d build/")
    syscall("rm -Rf NOOBS_v1_9_0.zip")
    
    #===== NOOBS clean-up
    
    syscall("rm -Rf build/os/Arch")
    syscall("rm -Rf build/os/OpenELEC")
    syscall("rm -Rf build/os/Pidora")
    syscall("rm -Rf build/os/RaspBMC")
    syscall("rm -Rf build/os/RISC_OS")
    
    #===== NOOBS marketing
    
    # default logo
    syscall("cp bits_n_pieces/openwsn_logo.png build/defaults/slides/A.png")
    
    # rename distribution
    syscall("mv build/os/Raspbian build/os/OpenPi")
    
    # installation options
    syscall("cp bits_n_pieces/os.json       build/os/OpenPi/os.json"),
    syscall("cp bits_n_pieces/flavours.json build/os/OpenPi/flavours.json")
    
    # installation logo
    syscall("rm build/os/OpenPi/Raspbian.png")
    syscall("cp bits_n_pieces/OpenPi.png    build/os/OpenPi/OpenPi.png")
    
    # installation intro slides (shown during installation)
    syscall("rm -Rf build/os/OpenPi/slides_vga")
    syscall("cp -r bits_n_pieces/slides_vga build/os/OpenPi/slides_vga")
    
    #===== OpenPi customization
    
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
    syscall("sudo cp bottle-0.12.7/bottle.py build/os/OpenPi/root/usr/local/lib/python2.7/dist-packages/")
    syscall("sudo mv bottle-0.12.7/bottle.py build/os/OpenPi/root/usr/local/bin/")
    syscall("sudo rm bottle-0.12.7.tar.gz")
    syscall("sudo rm -Rf bottle-0.12.7/")
    syscall("wget https://pypi.python.org/packages/source/P/PyDispatcher/PyDispatcher-2.0.3.tar.gz")
    syscall("tar -zxvf PyDispatcher-2.0.3.tar.gz")
    syscall("sudo mv PyDispatcher-2.0.3/pydispatch build/os/OpenPi/root/usr/local/lib/python2.7/dist-packages/")
    syscall("sudo rm PyDispatcher-2.0.3.tar.gz")
    syscall("sudo rm -Rf PyDispatcher-2.0.3/")
        
    # install OpenWSN-SW
    syscall("wget https://codeload.github.com/openwsn-berkeley/openwsn-sw/zip/develop")
    syscall("unzip develop")
    syscall("sudo rm develop")
    syscall("sudo mv openwsn-sw-develop openwsn-sw")
    syscall("sudo mv openwsn-sw build/os/OpenPi/root/home/pi/")
    
    # update modules to run
    syscall("sudo cp bits_n_pieces/modules build/os/OpenPi/root/etc/")
    
    # customize boot message, start OpenVisualizer on boot
    # syscall("sudo cp bits_n_pieces/rc.local build/os/OpenPi/root/etc")
    
    # compress root
    syscall("cd build/os/OpenPi/root/ ; sudo tar -cJf ../root.tar.xz ./ ; cd ../../../../")
    syscall("sudo rm -Rf build/os/OpenPi/root/")
    
    #===== OpenPi wrap-up and publish
    
    # create final zip
    syscall("cd build ; zip -r ../OpenPi.zip * ; cd ..")
    syscall("rm -Rf build")
    
    # copy to final location
    syscall("sudo mv OpenPi.zip {0}".format(localEnv['OW_PATH_OPENPI_OUT']))

#============================ SCons targets ===================================

build = localEnv.Command(
    'dummy.out',[],
    [
        ActionBuild,
    ]
)

localEnv.Alias('build', build)
