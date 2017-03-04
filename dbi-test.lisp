(require 'dbi)

(setq *conn*
      (dbi:connect :mysql
                   :host "127.0.0.1"
                   :database-name "collectd"
                   :username "collectd"
                   :password "collectd"))

(setq query (dbi:prepare *conn* "select d.timestamp, i.host, i.plugin, i.plugin_instance, d.value from data d join identifier i on d.identifier_id=i.id LIMIT 100;"))
(setq result (dbi:execute query))

(with-open-file (out "collectd2.csv"
                     :direction :output
                     :if-exists :supersede)
  (format out "timestamp;host;plugin;value~%")

  (loop for row = (dbi:fetch result)
     while row
     do (format out "~A;~A;~A;~,5F~%" (getf row :|timestamp|) (getf row :|host|) (getf row :|plugin|) (getf row :|value|))))







