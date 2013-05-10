# Manuscript

This file typically contains one or multiple file generation routines
used in conjunction with literate coffeescript to generate files on a
meta-programming level, having both executable code as well as textual
content (symbols that evaluate to their own literal value).

Inside it, is unlocked some of the knowledge of **what may be expected**
when someone would look (inspect) a typical Node.js package.

* We will define literal objects of conventional structures, directories
  and files and;
* try to automagically determine their file type, even if binary, using
  standard built-in Unix tools;
* prepare and impose a own structure upon others, such as create
  directories or files from available streams to use later;
* these streams can be combined to form a new, single document;
* gather any style information;
* send additional commands to other programs inside this system.

And any else I can think of I could do...


    T_PATH = {

        doc: {
            'README.litcoffee': '''Generalized node introduction, welcome and
            landing home page for many cloud based services by, say de-
            facto, convention.'''
        },
        extra: { 
            'metatron-cube.litcoffee': ''' A paper.js created
        geometric figure composed of 13 equal circles with lines from
        the center of each circle extending out to the centers of the
        other 12 circles.
        '''
        },
        src: {
            'manuscript': '''

            '''
        }

    walkdir = require 'walkdir'
    logger  = require 'winston'

