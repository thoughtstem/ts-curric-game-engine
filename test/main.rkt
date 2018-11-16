#lang racket

(require rackunit
         ts-curric-common
         pict
         "../main.rkt")


(check-equal? ((listof (or/c pict?
                             material?)) (quest1))
               #t
               "Quest 1 must return a list of picts/materials")

