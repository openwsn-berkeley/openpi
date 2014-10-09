Import('env')

def download_noobs(env,target,source):
    print 'TODO'

def copy_noobs(env,target,source):
    print 'TODO'

def unzip_noobs(env,target,source):
    print 'TODO'

def delete_OSs(env,target,source):
    print 'TODO'

def rename_Raspbian(env,target,source):
    print 'TODO'

def customize_marketing(env,target,source):
    print 'TODO'

def inflate_root(env,target,source):
    print 'TODO'

def customize_root(env,target,source):
    print 'TODO'

def compress_root(env,target,source):
    print 'TODO'

def zip_noobs(env,target,source):
    print 'TODO'

build = env.Command(
    'dummy.out',
    [],
    [
        download_noobs,
        unzip_noobs,
        delete_OSs,
        rename_Raspbian,
        customize_marketing,
        inflate_root,
        customize_root,
        compress_root,
        zip_noobs,
    ]
)
env.Alias('build', build)
