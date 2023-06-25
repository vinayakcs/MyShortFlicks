
# Project
Myshortflicks is a video socialnetwork for shortfilms , which served the Indian indie shortfilm makers from 2014 to 2016 , built using rails. The idea was to create a professional network of film makers who can upload their content and create a portfolio and interact with others.   

### Setup  
```bundle install```
```rails rails_admin:install```   
```rails assets:precompile```
```rails db:setup```
### DB Setup 
```
CREATE SCHEMA myshortflicks;
DROP USER 'myshortflicks'@'%' ;
CREATE USER 'myshortflicks'@'%' IDENTIFIED BY 'myshortflicks';
GRANT ALL ON myshortflicks.* TO 'myshortflicks'@'%';
GRANT ALL PRIVILEGES ON *.* TO 'myshortflicks'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
ALTER DATABASE myshortflicks CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE myshortflicks;
SELECT DATABASE();

```

### Environment variables
- export YOUTUBE_API_KEY="" (youtube v3 data api key)     

### Author
Vinayak srinivas [Linkedin](https://linkedin.com/in/vinayakcs)

### License
Creative Commons Attribution (CC BY)

### Demo
[![Demo](https://img.youtube.com/vi/rwA4yqD0Uxg/maxresdefault.jpg)](https://www.youtube.com/watch?v=rwA4yqD0Uxg)
