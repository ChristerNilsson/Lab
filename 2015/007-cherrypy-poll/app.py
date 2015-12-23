import cherrypy
from jinja2 import Environment,FileSystemLoader
from db_tools import get_value,set_value,del_value
from views import get_global_links,get_polls,get_poll,\
    cast_vote
from models import add_poll,edit_poll
import os.path

conf = os.path.join(os.path.dirname(__file__), 'app.conf')
env = Environment(loader=FileSystemLoader('templates'))

class PollViews:

    @cherrypy.expose
    def index(self):
        data_dict = {
            'title': 'Poll List',
            'links': get_global_links(),
            'polls': get_polls(),
        }                                             
        templ = env.get_template('polls.html')        
        return templ.render(data_dict)                


    @cherrypy.expose
    def poll(self,key,choice=None):
        method = cherrypy.request.method.upper()
        poll = False
        data_dict = {
            'title': 'Poll',
            'links': get_global_links(),
        }                                             
        if method == 'POST':
            data_dict['poll'] = cast_vote(key,choice)
            data_dict['success'] = True
        else:
            data_dict['poll'] = get_poll(key)
        if not data_dict.get('poll'):
            raise cherrypy.HTTPError(404)
        templ = env.get_template('poll.html')        
        return templ.render(data_dict)                


    @cherrypy.expose
    def add(self,**kwargs):
        method = cherrypy.request.method.upper()       
        poll = False                                   
        data_dict = {                                        
            'title': 'Add a poll',                           
            'links': get_global_links(),                     
        }                                                    
        if method == 'POST':                           
            add_poll(**kwargs)
            data_dict['success'] = True
        templ = env.get_template('add_poll.html')        
        return templ.render(data_dict)                

    @cherrypy.expose
    def edit(self,key,**kwargs):
        method = cherrypy.request.method.upper()       
        poll = False                                   
        data_dict = {                                        
            'title': 'Edit your poll',                           
            'links': get_global_links(),        
        }                                                    
        if method == 'POST':   
            poll = edit_poll(**kwargs)
            data_dict['poll'] = poll
            data_dict['success'] = True
        else:
            data_dict['poll'] = get_poll(key)
        templ = env.get_template('edit_poll.html')        
        return templ.render(data_dict)                       

class PollApp:
    polls = PollViews()

    @cherrypy.expose
    def index(self):
        data_dict = {
            'title': 'Welcome to the poll application!',
            'links': get_global_links(),
        }
        templ = env.get_template('index.html')
        return templ.render(data_dict)
    

if __name__ == '__main__':
    cherrypy.quickstart(PollApp(), config=conf)
else:
    cherrypy.tree.mount(PollApp(), config=conf)
