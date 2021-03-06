(ns scratch
  (:require [clojure.test :as test]
            [clojure.repl :as repl]
            [eftest.runner :as eftest]
            [clojure.tools.namespace.find :as ns.find]
            [clojure.tools.namespace.repl :as ns.repl]
            [clojure.java.io :as io])
  (:import (java.io File)))

(def multithread (atom false))
(defn init! []
  (ns scratch)
  (ns.repl/disable-reload! *ns*)
  (println (str ">>> in ns " *ns*))
  (println "(scratch/t) - run all tests
(scratch/t \".*some-ns.*\") - run tests for matching namespaces
(scratch/time+ \"tag\"  (some expr)) - like time, but better
(scratch/refresh) - refresh all namespaces
(scrtach/refresh-all) - refresh all project + dep namespaces
(scratch/list-ns) - find all namespaces in SRC"))

(def refresh ns.repl/refresh)
(def refresh-all ns.repl/refresh-all)

(defn list-ns
  "Return list of symbols of namespaces found in src dir"
  []
  (ns.find/find-namespaces-in-dir (File. "./src/")))

(defn t
  "Reload and run tests. Without arguments run all tests.
  If argument is passed (String) is interpreted as a regex to
  find a namespace"
  ([]
   (refresh)
   (eftest/run-tests (eftest/find-tests "test")
                     {:multithread? @multithread}))
  ([pattern]
   (let [regex (re-pattern pattern)
         nss (filter (fn [v] (re-find regex (str v)))
                     (eftest/find-tests "test"))]
     (refresh)
     (eftest/run-tests nss
                       {:multithread? @multithread}))))


(defmacro time+
  "Like time but:
  - accepts a `tag` argument
  - prints out start + end time
  - rounds up ms - less precise"
  [tag & body]
  (printf "start |%s| %s\n"  tag (java.time.LocalDateTime/now))
  `(let [start-time# ^Long (System/currentTimeMillis)
         return# (do
                   ~@body)
         time# ^Long (- (System/currentTimeMillis) start-time#)]
     (printf "end |%s| %s - %sms\n" ~tag   (str (java.time.LocalDateTime/now)) time#)
     return#))

(init!)
