Import('env')

import zipfile
import tarfile
import os.path
import os
import urllib
import sys

localEnv = env.Clone()

#============================ defines =========================================

#============================ helpers =========================================

def zipCompress(output, zip):
    output = os.path.normpath(output)
    # os.walk visits every subdirectory, returning a 3-tuple
    # of directory name, subdirectories in it, and file names
    # in it.
    for (dirpath, dirnames, filenames) in os.walk(output):
        # Iterate over every file name
        for file in filenames:
            print "Adding %s..." % os.path.join(output, dirpath, file)
            try:
                zip.write(os.path.join(dirpath, file),
                os.path.join(dirpath[len(output):], file)) 
                    
            except Exception, e:
                print "    Error adding %s: %s" % (file, e)

    return None


#============================ SCons actions ===================================

def ActionUnzip(env,target,source):
    zfile = zipfile.ZipFile("NOOBS_v1_3_9.zip")
    zfile.extractall("build/")
    zfile.close()

def ActionExtractRootTarXz(env,target,source):
    os.system("pwd")
    os.system("sudo tar -xJf build/os/OpenPi/root.tar.xz build/os/OpenPi/")

def ActionPythonPackageBottle(env,target,source):
    os.system("wget https://pypi.python.org/packages/source/b/bottle/bottle-0.12.7.tar.gz")
    os.system("tar -zxvf bottle-0.12.7.tar.gz")

def ActionPythonPackagePyDispatcher(env,target,source):
    os.system("wget https://pypi.python.org/packages/source/P/PyDispatcher/PyDispatcher-2.0.3.tar.gz")
    os.system("tar -zxvf PyDispatcher-2.0.3.tar.gz")

def ActionDownloadOpenWSN(env,target,source):
    urllib.urlretrieve('https://github.com/openwsn-berkeley/openwsn-sw/archive/REL-1.8.0.zip','openwsn-sw.zip')

def ActionUnzipOpenWSN(env,target,source):
    zfile = zipfile.ZipFile("openwsn-sw.zip")
    zfile.extractall(".")
    zfile.close()

def ActionCompressRootTarXz(env,target,source):
    os.system("sudo tar -cJf build/os/OpenPi/root.tar.xz build/os/OpenPi/root/ > ActionCompressRootTar.log")

def ActionZip(env,target,source):
    zfile = zipfile.ZipFile("OpenPi.zip", 'w', zipfile.ZIP_DEFLATED)
    zipCompress("build/", zfile)
    zfile.close()

#============================ SCons targets ===================================

build = localEnv.Command(
    'dummy.out',[],
    [
        #===== get NOOBS
        
        Copy( Dir('#'), localEnv['OW_PATH_NOOBS_IN'] ),
        Delete("build"),
        Mkdir("build"),
        ActionUnzip,
        Delete("NOOBS_v1_3_9.zip"),
        
        #===== clean up
        
        Delete("build/os/Arch"),
        Delete("build/os/OpenELEC"),
        Delete("build/os/Pidora"),
        Delete("build/os/RaspBMC"),
        Delete("build/os/RISC_OS"),
        
        #===== marketing
        
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
        
        #===== customization
        
        # extract root
        ActionExtractRootTarXz,
        Delete("build/os/OpenPi/root.tar.xz"),
        
        # change desktop background image (do here, after root/ un-tared)
        Delete("build/os/OpenPi/root/etc/alternatives/desktop-background"),
        Copy("build/os/OpenPi/root/etc/alternatives","bits_n_pieces/desktop-background"),
        
        # install python module dependencies (bottle, PyDispatcher)
        ActionPythonPackageBottle,
        Move("build/os/OpenPi/root/usr/local/lib/python2.7/site-packages/","bottle-0.12.7/bottle.py"),
        Delete("dist/"),
        Delete("bottle-0.12.7.tar.gz"),
        Delete("bottle-0.12.7/"),
        ActionPythonPackagePyDispatcher,
        Move("build/os/OpenPi/root/usr/local/lib/python2.7/site-packages/","PyDispatcher-2.0.3/pydispatch"),
        Delete("dist/"),
        Delete("PyDispatcher-2.0.3.tar.gz"),
        Delete("PyDispatcher-2.0.3/"),
        
        # install OpenWSN-SW
        ActionDownloadOpenWSN,
        ActionUnzipOpenWSN,
        Delete("openwsn-sw.zip"),
        Move("build/os/OpenPi/root/home/pi/openwsn-sw","openwsn-sw-REL-1.8.0/"),
        Copy("build/os/OpenPi/root/etc/","bits_n_pieces/modules"),
        
        # customize boot message, start OpenVisualizer on boot
        Copy("build/os/OpenPi/root/etc","bits_n_pieces/rc.local"),
        
        # compress root
        ActionCompressRootTarXz,
        Delete("build/os/OpenPi/root/"),
        
        #===== wrap-up and publish
        
        ActionZip,
        Delete("build"),
        # copy to final location
        Copy( localEnv['OW_PATH_OPENPI_OUT'], "OpenPi.zip" ),
    ]
)

localEnv.Alias('build', build)
