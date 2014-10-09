Import('env')

import zipfile
import os.path
import os

localEnv = env.Clone()

# unzip a file
def unzip(path,outdir):
    zfile = zipfile.ZipFile(path)
    for name in zfile.namelist():
        (dirname, filename) = os.path.split(name)
        print "unzip "+filename+" on "+dirname
        if not os.path.exists(outdir+dirname):
            os.makedirs(outdir+dirname)
        zfile.extract(name,outdir+dirname)
    zfile.close()

build = localEnv.Command(
    'dummy.out',
    [],
    [
        # copy NOOBS to current directory
        Copy( Dir('#'), localEnv['OW_PATH_NOOBS_IN'] ),
        # unzip NOOBS
        unzip("NOOBS_v1_3_10.zip","OpenPi/"),
        # delete OSes
        # TODO
        # rename Raspbian
        # TODO
        # customize marketing
        # TODO
        # inflate root,
        # TODO
        # customize root,
        # TODO
        # compress root,
        # TODO
        # zip noobs,
        # TODO
        # copy to final location
        # TODO
    ]
)
localEnv.Alias('build', build)
