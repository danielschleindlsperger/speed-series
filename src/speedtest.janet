(import sh)
(import json)
(import db)

(defn run-speedtest!
  []
  ``Run an internet connection test with the speedtest.net CLI and
  persist the result as well as the server information to the database.
  Note: This is highly side-effect-ful and takes atleast a few seconds to execute.
        Should be run in a separate thread in order to not block anything.
  ``
  (let [json-result (json/decode (sh/$< speedtest "--format=json"))
        result  {:id (get-in json-result ["result" "id"])
                 # :timestamp (get json-result "timestamp")
                 # TODO: actual timestamp instead of ISO date
                 # We can parse the ISO date with PEGs and sum up the components
                 :timestamp (os/time)
                 :url (get-in json-result ["result" "url"])
                 :download-bandwidth-bytes (get-in json-result ["download" "bandwidth"])
                 :upload-bandwidth-bytes (get-in json-result ["upload" "bandwidth"])
                 :latency-ms (get-in json-result ["ping" "latency"])
                 :jitter (get-in json-result ["ping" "jitter"])
                 :server-id (get-in json-result ["server" "id"])}
        server {:id (get-in json-result ["server" "id"])
                :name (get-in json-result ["server" "name"])
                :country (get-in json-result ["server" "country"])
                :location (get-in json-result ["server" "location"])}]
    (db/insert :results result)
    (db/insert :servers server)
    {:result result
    :server server}))
