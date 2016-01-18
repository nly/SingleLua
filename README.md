# SingleLua Framework


    http {
        lua_shared_dict ctrs 2m;
    }

    server {
        listen 80;
        server_name singlelua.app;
        root /Users/leandre/Works/Codingx;

        lua_code_cache off;

        location / {
            default_type text/html;
            content_by_lua_file $document_root/app.lua;
        }

        location ~* ^/(css|img|js|flv|swf|download)/(.+)$ {
            root /Users/leandre/Works/Codingx/public;
        }

        location ~* "^/favicon\.ico" {
           expires 30d;
           root /Users/leandre/Works/Codingx/public;
        }
    }