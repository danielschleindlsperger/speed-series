(import joy)
(import db)
(import json)

(defn- dashboard-page [speedtest-results servers]
  (joy/html
     [:html {:lang "en"}
      [:head
       [:meta {:charset "utf-8"}]
       [:meta {:name "viewport" :content "width=device-width, initial-scale=1"}]
       # [:link {:href "/app.css" :rel "stylesheet"}]
       [:title "SpeedSeries"]]
      [:body
         [:h1 "SpeedSeries Dashboard"]
         [:section {:id "chart" }]
         [:script {:type "application/json" :id "chart-data"} (joy/raw (json/encode speedtest-results))]
         [:script {:src "https://cdn.jsdelivr.net/npm/apexcharts"}]
         [:script {:src "/app.js"}]]]))

(def- week-in-secs (* 7 24 60 60))

(defn show-dashboard [req]
  (let [range (- (os/time) week-in-secs)
        servers (db/from :servers)
        speedtest-results (db/from :results :where ["timestamp > ?" range])]
    {:status 200
     :body (dashboard-page speedtest-results servers)
     :headers @{"Content-Type" "text/html"}}
    ))
