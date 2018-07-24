set history save on
set history size 1000
set history remove-duplicates 1
set history expansion on
set history filename ~/.gdb_history

# remove duplicate commands
python
import os
file_name = "~/.gdb_history"
with open() as f:
    contents = set([line.rstrip() for line in f.readlines()])
with open() as f:
    f.write('\n'.join(contents) + '\n')
end
