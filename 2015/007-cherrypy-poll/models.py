from db_tools import get_value,set_value,del_value 
from utils import slugify
from views import publish_poll

def add_poll(**kwargs):
    choices_arr = []
    count = 1
    poll_dict = {}
    poll_dict['question'] = kwargs.get('question')
    for k,v in kwargs.items():
        if 'choice' not in k: continue
        if not v: continue
        choice_dict = {
            'id': count,
            'text': v,
            'value': 0
        }
        choices_arr.append(choice_dict)
        count += 1
    slug = slugify(kwargs.get('question')) 
    poll_dict['slug'] = slug
    poll_dict['choices'] = choices_arr
    set_value(slug,poll_dict)
    if kwargs.get('publish'):
        publish_poll(slug)


def edit_poll(**kwargs):
    choices_arr = []
    poll = get_poll(str(kwargs.get('slug')))
    poll_dict = {}
    poll_dict['question'] = kwargs.get('question')
    for k,v in kwargs.items():
        if 'choice' not in k: continue
        this_choice = [c for c in poll.get('choices') if int(k.strip('choice')) == c.get('id')]
        if not len(this_choice):
            return False
        else:
            this_choice = this_choice[0]
        choice_dict = {
            'id': this_choice.get('id'),
            'text': v,
            'value': this_choice.get('value'),
        }
        choices_arr.append(choice_dict)
    slug = str(kwargs.get('slug'))
    poll_dict['slug'] = slug
    poll_dict['choices'] = choices_arr
    set_value(slug,poll_dict)
    if kwargs.get('publish'):
        publish_poll(slug)
    else:
        unpublish_poll(slug)
    return poll_dict
