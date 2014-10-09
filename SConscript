Import('env')

import zipfile
import os.path
import os

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
        # copy NOOBS to current directory
        Copy( Dir('#'), localEnv['OW_PATH_NOOBS_IN'] ),
        # unzip NOOBS
        unzip("NOOBS_v1_3_10.zip"),
        # delete OSes
        deleteOSes("OpenPi/");
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
