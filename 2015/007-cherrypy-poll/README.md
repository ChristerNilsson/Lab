CherryPy Polling Application
=========================

A tutorial-based introduction to python using CherryPy. 

Virtual Env
------------

If you'd like to use virtual environments, please follow the following instructions. It is not required for the tutorial but may be helpful.

For more details on [virtual environments](http://www.doughellmann.com/projects/virtualenvwrapper/)

If you don't have virtual env wrapper and/or pip: 
    
    $ easy_install pip
    $ pip install virtualenvwrapper
    
and read the additional instructions [here](http://virtualenvwrapper.readthedocs.org/en/latest/install.html)


    $ mkvirtualenv cherrypytutorial
    $ pip install -r requirements.txt


Memcache and LibMemcache Setup
-------------------------
You will need both memcache and libmemcached to use this tutorial. For more information on each and to get downloads, please visit [LibMemcache](https://launchpad.net/libmemcached/) and [memcached](http://memcached.org/)

If you are using a Mac, this [might be a good resource](http://tugdualgrall.blogspot.com/2011/11/installing-memcached-on-mac-os-x-and.html)

If you are using Windows, this [might be a good resource](http://www.codeforest.net/how-to-install-memcached-on-windows-machine)

Depending on your file system, you will need additional compiler packages to install pylibmc. If you are using homebrew, you can run:

    $ brew install libmemcached

Please reach out to us if you have any questions on getting the initial requirements set up. Thanks!


Questions?
----------
/msg kjam on freenode.

