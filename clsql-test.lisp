#!/usr/bin/sbcl --script

(load ".sbclrc")
(require "clsql")

(setq *conn*
      (clsql:connect '("127.0.0.1" "collectd" "collectd" "collectd") :database-type :mysql))
(setq query "SELECT d.timestamp, i.host, i.plugin, i.plugin_instance, d.value FROM data d JOIN identifier i ON d.identifier_id=i.id WHERE i.plugin='smmp' LIMIT 20;")

(loop for row in (clsql:query query :field-names t) do
     (format t "[~A] host ~A sensor ~A value ~,5F~%" (nth 0 row) (nth 1 row) (nth 3 row) (nth 4 row)))

