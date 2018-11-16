#lang racket

(require rackunit
         ts-curric-common
         pict
         "../main.rkt")


(define (test-quest q)
                    (check-equal? ((listof (or/c pict?
                                                 material?)) (q))
                                  #t
                                  "A quest must return a list of picts/materials"))

(map test-quest
     (quests))



