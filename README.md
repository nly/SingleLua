# SingleLua Framework

add this to nginx http block:

~~~
http {
    lua_package_path '/Users/leandre/Works/SingleLua/?.lua;;';

    lua_shared_dict ctrs 2m;
}
~~~

add a site vhost:

~~~
server {
    listen 80;
    server_name singlelua.app;
    root /Users/leandre/Works/SingleLua;

    lua_code_cache off;

    location / {
        default_type text/html;
        content_by_lua_file $document_root/app.lua;
    }

    location ~* ^/(css|img|js|flv|swf|download)/(.+)$ {
        root /Users/leandre/Works/SingleLua/public;
    }

    location ~* "^/favicon\.ico" {
       expires 30d;
       root /Users/leandre/Works/SingleLua/public;
    }
}
~~~

/etc/hosts 

`127.0.0.1 singlelua.app`
