# esto namás cambia los nombres de textos_individuales/ para que se llamen

# 001.txt, 002.txt.

import os
path = 'topic_modeling/textos_individuales/'
for filename in os.listdir(path):
    new_filename = filename.zfill(7)
    os.rename(os.path.join(path, filename), os.path.join(path, new_filename))