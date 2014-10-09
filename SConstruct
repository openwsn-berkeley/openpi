import os
import sys

import SCons

#============================ banner ==========================================

banner  = []
banner += [""]
banner += [" ___                 _ _ _  ___  _ _ "]
banner += ["| . | ___  ___ ._ _ | | | |/ __>| \ |"]
banner += ["| | || . \/ ._>| ' || | | |\__ \|   |"]
banner += ["`___'|  _/\___.|_|_||__/_/ <___/|_\_|"]
banner += ["     |_|                  openwsn.org"]
banner += [""]
banner  = '\n'.join(banner)
print banner

#===== help text

Help('''
Usage:
    scons build
''')

#============================ options =========================================

command_line_vars = Variables()

env = Environment(
    variables = command_line_vars
)

def default(env,target,source): print SCons.Script.help_text
Default(env.Command('default', None, default))

#============================ environment variables ===========================

for (k,v) in os.environ.items():
    if k.startswith('OW_'):
        env[k] = v

#============================ load SConscript(s) ==============================

env.SConscript(
    'SConscript',
    exports = ['env'],
)
