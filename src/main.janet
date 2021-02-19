(import db)
(import ./speedtest)

(defn main [& args]
  (db/connect "db.sqlite3")
  (let [speedtest (speedtest/run-speedtest!)]
    (print "success!")))
