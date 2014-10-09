Import('env')

localEnv = env.Clone()

def unzip(filename):
    print filename

build = localEnv.Command(
    'dummy.out',
    [],
    [
        # copy NOOBS to current directory
        Copy( Dir('#'), localEnv['OW_PATH_NOOBS_IN'] ),
        # unzip NOOBS
        unzip('poipoi2'),
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
