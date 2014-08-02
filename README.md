quickquote
==========

An Insurance Quote app for the Sydney Testers "Faster Tests, Faster Feedback" workshop

####URL for the webapp, hosted on heroku: 
http://sydneytesters.herokuapp.com/

####Things to have stup on your machine 
(just google them to find installers):
1. git
2. ruby 2.0.x
3. bundler gem
4. chrome
5. chromedriver (http://chromedriver.storage.googleapis.com/index.html?path=2.10/

 Unzip chromedriver, copy the unzipped file into any folder in your PATH and then make it executable.)
6. phantomjs

####To set up the project on your machine:
1. `git clone https://github.com/hdushan/quickquote.git`
2. `bundle install`

####Rake targets to run tests locally:
- `rake unit` *runs unit tests only*
- `rake chrome` *runs cucumber tests using chrome*
- `rake headless` *runs cucumber tests using phantomjs*
- `rake` *runs unit tests and cucumber tests headless*

####To run the app locally:
1. In the quickquote folder, run '`shotgun`'
2. Use a browser to navigate to 'http://localhost:9393'

####Rake targets to run tests against the heroku-hosted app:
- `rake qa_chrome` *runs cucumber tests using chrome*
- `rake qa_headless` *runs cucumber tests using phantomjs*

####Selenium Grid:
######To start hub
In folder quickquote/grid:
- `java -jar selenium-server-standalone-2.42.2x.jar -role hub`

######To start node (Chrome/OSX)
In folder quickquote/grid:
- `java -jar selenium-server-standalone-2.42.2x.jar -role node -nodeConfig osxchrome.json`

######To start node (Chrome/Win7)
In folder quickquote\grid:
- `java -jar selenium-server-standalone-2.42.2x.jar -role node -nodeConfig win7chrome.json -Dwebdriver.chrome.driver=Y:\Workspace\quickquote\grid\chromedriver.exe`

####Rake targets to run tests parallely against heroku-hosted app 
(Note: best to have 3 nodes running):
- `rake qa_chromeparallel` *runs cucumber tests parallely using chrome*
- `rake qa_headlessparallel` *runs cucumber tests parallely using phantomjs*

####Rake targets to run tests parallely against local app 
(Note: best to have 3 nodes running, all on the same machine as the server):
- `rake chromeparallel` *runs cucumber tests parallely using chrome*
- `rake headlessparallel` *runs cucumber tests parallely using phantomjs*

####Travis build for above webapp:
Search for the public repository “**quickquote**” at 
https://travis-ci.org/