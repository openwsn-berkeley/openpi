import os
import sys
import platform
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

#============================ load SConscript(s) ==============================

env.SConscript(
    'SConscript',
    exports = ['env'],
)
