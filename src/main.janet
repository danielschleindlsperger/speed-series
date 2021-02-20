(import db)
(import joy)
(import ./speedtest)
(import ./dashboard)

(def routes (joy/routes [:get "/" dashboard/show-dashboard]))

(def app (joy/app {:routes routes}))

# TODO: generate a config object at startup

(defn main [& args]
  (db/connect (or (os/getenv "DATABASE_URL") "db.sqlite3"))
  # TODO: run in schedule
  (speedtest/run-speedtest!)
  (joy/server app 9001)
  (db/disconnect))
