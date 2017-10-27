with open('car.yml') as f:
    lines = f.readlines()

res = []
for line in lines:
    #if not 'created:' in line and not 'updated:' in line:
    # 'dialog_node:' in line or 'previous_sibling:' in line or
    if  'parent:' in line:
        res.append(line.rstrip())
for line in set(res):
    print line

