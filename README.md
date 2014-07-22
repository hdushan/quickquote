quickquote
==========

An Insurance Quote app for the Sydney Testers "Faster Tests, Faster Feedback" workshop

URL for the webapp, hosted on heroku: 
http://sydneytesters.herokuapp.com/

To set up the project on your machine:
- git clone https://github.com/hdushan/quickquote.git
- bundle install
- rake #runs unit tests and cucumber tests headless
- rake unit #runs unit tests only
- rake chrome #runs cucumber tests using chrome*
- rake headless #runs cucumber tests using phantomjs

*Link to chromedriver (need this for selenium to be able to start chrome):
http://chromedriver.storage.googleapis.com/2.10/chromedriver_mac32.zip
- Copy the unzipped file into any folder in your PATH and then make it executable.

To run the app locally:
- In the quickquote folder, run 'shotgun'
- Use a browser to navigate to 'http://localhost:9393'

Other rake targets:
- rake qa_chrome #runs cucumber tests using chrome*, against the heroku-hosted app
- rake qa_headless #runs cucumber tests using phantomjs, against the heroku-hosted app

Selenium Grid:
- To start hub, from quickquote/grid:
java -jar selenium-server-standalone-2.42.2x.jar -role hub

- To start node (Chrome/OSX), from quickquote/grid:
java -jar selenium-server-standalone-2.42.2x.jar -role node -nodeConfig osxchrome.json

- To start node (Chrome/Win7), from quickquote\grid:
Y:\Workspace\quickquote\grid>java -jar selenium-server-standalone-2.42.2x.jar -role node -nodeConfig win7chrome.json -Dwebdriver.chrome.driver=Y:\Workspace\quick
quote\grid\chromedriver.exe


Travis build for above webapp:
https://travis-ci.org/
- search for the public repository “quickquote”

Slides for workshop:
https://trello.com/b/phvML2XB/fastertestsslides

Plan for workshop:

- Demonstrate the problem (ie time the tests as is)
- Demonstrate how parallelisation improves it (ie time the tests after using selenium grid to distribute it across two machines)
- Demonstrate how a headless browser improves it (ie time the test after changing it to use selenium/phantomjs instead of selenium/chrome)
- Demonstrate how adhering to the Test pyramid improves it (ie time the test after moving some tests to the unit test layer)


