## GET APIs
`--data-urlencode` followed by key=value in quotes. it will urlencode all the spaces in the value part and send them as request params in Url. 
# General
`-X` Followed-by method-Name e.g POST|PUT|GET or you can use options as `--get` `--post`.
option = -H Followed-by = Header tuple in json e.g 'Content-Type:application/json'
option = -d/--data followed-by = data payload filename e.g. @byfield.doc
option = --trace-time --trace-ascii --verbose to debug information
option = -u followed-by  = username:password 
option = --head gives u header information

option = --form followed-by = @uploadfile e.g. curl --form upload=@localfilename --form press=OK [URL]
otpion = --user-agent followed-by user-agent string "Mozilla/4.0 (compatible; MSIE 5.01; Windows NT 5.0)" 
option = --location allow curl to follow redirection


