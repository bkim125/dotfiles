set history save on
set history size 1000
set history remove-duplicates 1
set history expansion on
set history filename ~/.gdb_history

# remove duplicate commands
python
import os
import getpass
file_name = "/home/{}/.gdb_history".format(getpass.getuser())
with open(file_name) as f:
    contents = set([line.rstrip() for line in f.readlines()])
with open(file_name, 'w') as f:
    f.write('\n'.join(contents) + '\n')
end
