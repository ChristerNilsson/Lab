import pylibmc

def get_mc():
    mc = pylibmc.Client(['127.0.0.1:11211'])
    return mc

def get_value(key):
    mc = get_mc()
    val = mc.get(key)
    del mc
    return val

def set_value(key,value):
    mc = get_mc()
    mc.set(key,value)
    del mc
    return True

def del_value(key):
    mc = get_mc()
    mc.delete(key)
    del mc
    return True

