1. Use session ID as record ID on database, then delete the record if expired [link](https://gist.github.com/aponxi/4744438)
2. Maybe we should implement request store too [link](https://github.com/steveklabnik/request_store)
3. Look at this repo for design pattern reference [link](https://github.com/weboAp/Visitor)

when use database method, mostly other softwares uses `DELETE where(expired_time < time)`

References how to expiring key in redis:
1. https://github.com/antirez/redis/issues/3192
2. https://stackoverflow.com/questions/16545321/how-to-expire-the-hset-child-key-in-redis
3. https://github.com/antirez/redis/issues/1042

maybe we can build it in following namespace format  
* {session-id}-total               `this namespace should be called everytime`  
* {sesion_id}-page-{page_name}     `page_name could be root_page`
* {sesion_id}-topics/-{topic_id}  


