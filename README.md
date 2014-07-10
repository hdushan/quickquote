quickquote
==========

An Insurance Quote app for the Sydney Testers "Faster Tests, Faster Feedback" workshop

Tasks:

Create a test web app, and host it on Heroku:
- Insurance Quick Calc
- Should do a calculation based on fields inputted in a form
- One of the fields is an email address which has to be validated
- Serverside hand-made validation for email address (not done yet)
- Create a few unit tests:
… 1x unit tests for different combinations of input
… 1x unit tests for email validation
- Create a few cucumber/webdriver tests:
… 4x tests for different combinations of input
… 4x tests for email validation (not done yet)
- Have unit tests and cucumber tests as part of the webapp’s codebase

URL for above webapp (work in progress): 
http://rocky-brook-3953.herokuapp.com/

To set up the project on your machine:
- git clone https://github.com/hdushan/quickquote.git
- bundle install
- rake parallel:create #Create your test databases. This is done by the following command. It creates as many databases as your PC has CPU cores.
- rake parallel:prepare #Prepares your test databases with the db schema.
- rake #runs unit tests and cucumber tests headless
- rake unit #runs unit tests only
- rake chrome #runs cucumber tests using chrome*
- rake headless #runs cucumber tests using phantomjs

*Link to chromedriver (need this for selenium to be able to start chrome):
http://chromedriver.storage.googleapis.com/2.10/chromedriver_mac32.zip
- Copy the unzipped file into any folder in your PATH and then make it executable.

Travis build for above webapp:
https://travis-ci.org/
- search for the public repository “quickquote”

Plan for workshop:

- Demonstrate the problem (ie time the tests as is)
- Demonstrate how parallelisation improves it (ie time the tests after using selenium grid to distribute it across two machines)
- Demonstrate how a headless browser improves it (ie time the test after changing it to use selenium/phantomjs instead of selenium/chrome)
- Demonstrate how adhering to the Test pyramid improves it (ie time the test after moving some tests to the unit test layer)


