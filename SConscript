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

def ActionExtractRootTarXz(env,target,source):
    os.system("7z.exe x build/os/OpenPi/root.tar.xz -y -obuild/os/OpenPi/ > ActionExtractRootTarXz.log")

def ActionExtractRootTar(env,target,source):
    os.system("7z.exe x build/os/OpenPi/root.tar -y -obuild/os/OpenPi/root/ > ActionExtractRootTar.log")

def ActionDownloadOpenWSN(env,target,source):
    urllib.urlretrieve('https://github.com/openwsn-berkeley/openwsn-sw/archive/REL-1.8.0.zip','openwsn-sw.zip')

def ActionUnzipOpenWSN(env,target,source):
    zfile = zipfile.ZipFile("openwsn-sw.zip")
    zfile.extractall(".")
    zfile.close()

def ActionPythonPackageBottle(env,target,source):
    wget('https://pypi.python.org/packages/source/b/bottle/bottle-0.12.7.tar.gz')
    os.system("7z.exe x bottle-0.12.7.tar.gz -y > ActionDownloadPythonPackages.log")
    os.system("7z.exe x dist/bottle-0.12.7.tar -y >> ActionDownloadPythonPackages.log")

def ActionPythonPackagePyDispatcher(env,target,source):
    wget('https://pypi.python.org/packages/source/P/PyDispatcher/PyDispatcher-2.0.3.tar.gz')
    os.system("7z.exe x PyDispatcher-2.0.3.tar.gz -y >> ActionDownloadPythonPackages.log")
    os.system("7z.exe x dist/PyDispatcher-2.0.3.tar -y >> ActionDownloadPythonPackages.log")

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
        
        # installation slides
        Delete("build/os/OpenPi/slides_vga"),
        Copy("build/os/OpenPi/slides_vga","bits_n_pieces/slides_vga"),
        
        #===== customization
        
        # extract root
        ActionExtractRootTarXz,
        Delete("build/os/OpenPi/root.tar.xz"),
        ActionExtractRootTar,
        Delete("build/os/OpenPi/root.tar"),
        
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
        # Done. (using tar -cJf ../root.tar.xz ./ in ubuntu environment)
        
        #===== wrap-up and publish
        # zip noobs,
        # Done.
        # copy to final location
        # TODO.
    ]
)

localEnv.Alias('build', build)
