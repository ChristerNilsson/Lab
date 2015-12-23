from db_tools import get_value,set_value,del_value 
from utils import slugify

def cast_vote(poll_key,choice):
    poll = get_value(poll_key)
    for c in poll['choices']:
        if c['id'] == int(choice):
            c['value'] += 1
    set_value(poll_key,poll)
    return poll

def get_global_links():
    return [{
        'name': 'Add a poll',
        'url': '/polls/add',
        },
        {
        'name': 'Home',
        'url': '/'
        },
        {
        'name': 'Poll list',
        'url': '/polls',
        }]

def get_poll(key):
    poll = get_value(key)
    return poll


def get_polls():
    poll_list = []
    published_polls = get_value('published_polls')
    if not published_polls:
        set_value('published_polls',[])
    for p in published_polls:
        poll = get_value(p)
        poll_list.append(poll)
    return poll_list

def publish_poll(key):
    published_polls = get_value('published_polls')
    if not published_polls:               
        set_value('published_polls',[])   
    if key not in published_polls:
        published_polls.append(key)
        set_value('published_polls',published_polls)

def unpublish_polls(key):
    published_polls = get_value('published_polls')   
    if not published_polls:               
        set_value('published_polls',[])  
    if key in published_polls:
        published_polls.remove(key)
        set_value('published_polls',published_polls)


