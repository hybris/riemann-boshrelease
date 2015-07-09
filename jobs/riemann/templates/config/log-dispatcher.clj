(def log-dispatcher
  "count-metric"
    (where (service #".*log-dispatcher.*.*.MessagesStoredInKafka.meter.one-minute")
      (split
        (< metric 10) (with :state "critical" alert)
      )
    )
    (where (service #".*log-dispatcher.*.*.MessagesStoredInKafka.meter.five-minute")
      (split
        (< metric 10) (with :state "critical" alert)
      )
    )
; where
) ;def
